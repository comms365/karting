# model
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, to: :limitedmanage
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :manage, UserSiteSession
      can :read, Site
    else
      can :read, Site
      cannot :manage, User
      cannot :manage, UserSiteSession
    end
  end
end
