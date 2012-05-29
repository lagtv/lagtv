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
      can :manage, Replay
    elsif current_user.member?
      # member permissions
      can :create, Replay do |replay|
        replay.user == current_user
      end
    end
  end
end
