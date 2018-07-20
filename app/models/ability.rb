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
    elsif not user_signed_in
      can :read, Site
      cannot :manage, User
      cannot :manage, UserSiteSession
    end

  end
end
