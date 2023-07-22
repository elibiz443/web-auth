# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? :super_admin
      can :manage, User
    elsif user.is? :admin
      can :manage, User
    elsif user.is? :customer
      can :manage, User, id: user.id
    else
      can :read, User
    end
  end
end
