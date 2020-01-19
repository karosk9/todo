class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    return 'Incognito user' unless first_name? || last_name?
    "#{first_name} #{last_name}"
  end
end
