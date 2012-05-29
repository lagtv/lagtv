class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new # guest user (not logged in)

    if current_user.admin?
      # admin permissions
      can :manage, :all
    elsif current_user.community_manager?
      # community manager permissions
      can :manage, User
    else
      # member permissions
      can :edit, User do | user |
        user == current_user
      end
    end
  end
end
