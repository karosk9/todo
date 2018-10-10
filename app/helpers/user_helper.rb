module UserHelper
  def full_name
    return 'Incognito user' unless current_user.first_name? && current_user.last_name?
    "#{current_user.first_name} #{current_user.last_name}"
  end
end
