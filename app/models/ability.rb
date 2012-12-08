class Ability
  include CanCan::Ability

  # Note that forum permissions is handled by the forem_admin attribute on the user which is set the the user_observer
  def initialize(current_user)
    if current_user
      if current_user.admin?
        can :manage, :all
      elsif current_user.community_manager?
        can :manage, User
        can :manage, Replay
        can :manage, Comment
        can :view, :latest_posts
        cannot :change_role, User
        cannot :change_status, User do |user|
          user.role == 'community_manager' || user.role == 'admin'
        end
        cannot :change_password, User do |user|
          user != current_user
        end
        cannot :edit, User do |user|
          user.admin?
        end
      elsif current_user.analyst?
        member_abilities(current_user)
        can :manage, Replay
        can :create, Comment
        can :edit, Comment do |comment|
          comment.user == current_user
        end
      elsif current_user.moderator? || current_user.dev_team?
        member_abilities(current_user)
        can :view, :latest_posts
      elsif current_user.member?
        member_abilities(current_user)
      end
    end
  end

  def member_abilities(current_user)
    can :edit, User do | user |
      user == current_user
    end
    can :change_password, User do |user|
      user == current_user
    end
    can :create, Replay do |replay|
      replay.user == current_user
    end
  end
end