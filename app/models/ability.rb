class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      # admin permissions
      can :manage, :all
    elsif user.community_manager?
      # community manager permissions
      can :manage, User
    else
      # member permissions

    end
  end
end
