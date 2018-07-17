class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :read, Site
      can :manage, UserSiteSession
    else
      can :read, :all
    end

  end
end
