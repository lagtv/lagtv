class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new # guest user (not logged in)

    # if user.admin?
    #   can :manage, :all
    # else user.community_manager?
      
    # else
    #   can :read, :all
    # end
  end
end
