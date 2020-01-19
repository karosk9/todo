class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def full_name
    return 'Incognito user' unless first_name? || last_name?
    "#{first_name} #{last_name}"
  end

  def profile_image_small
    return '' unless avatar.present?
    image_tag(avatar, size: 50)
  end

  def profile_image
    return '' unless avatar.present?
    image_tag(avatar, size: 300)
  end

  def data
    full_name == 'Incognito user' ? email : full_name
  end
end
