class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :limitedmanage
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :read, Site
      can :manage, UserSiteSession
    else
      can :read, Site
    end

  end
end
