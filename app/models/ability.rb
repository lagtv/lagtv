class Ability
  include CanCan::Ability

  # Note that forum permissions is handled by the forem_admin attribute on the user which is set the the user_observer
  def initialize(current_user)
    if current_user
      if current_user.admin?
        # admin permissions
        can :manage, :all
      elsif current_user.community_manager?
        # community manager permissions
        can :manage, User
        can :manage, Replay
        can :manage, Comment
        cannot :change_role, User
      elsif current_user.member? || current_user.moderator?
        # member permissions
        can :edit, User do | user |
          user == current_user
        end
        can :create, Replay do |replay|
          replay.user == current_user
        end
      end
    end
  end
end