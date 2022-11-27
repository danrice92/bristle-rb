class UserPolicy < ApplicationPolicy
  def requested_user_is_current_user?
    user.id == record.id
  end

  def create?
    true
  end

  alias_method :update?, :requested_user_is_current_user?
  alias_method :show?, :requested_user_is_current_user?
end