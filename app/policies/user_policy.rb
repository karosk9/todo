class UserPolicy
  attr_reader :user, :other_user

  def initialize(user, other_user)
    @user = user
    @other_user = other_user
  end

  def update?
    user.admin? || other_user == user
  end

  def edit?
    user.admin? || other_user == user
  end

  def destroy?
    user.admin? || other_user == user
  end
end
