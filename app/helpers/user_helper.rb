module UserHelper
  def full_name
    return current_user.email unless current_user.first_name? && current_user.last_name?
    "#{current_user.first_name} #{current_user.last_name}"
  end
end
