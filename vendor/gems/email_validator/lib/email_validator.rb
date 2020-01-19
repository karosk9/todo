require 'active_model'

class EmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless self.class.valid?(value)
      record.errors.add(attribute, options[:message] || :invalid_email_format)
    end
  end

  def self.valid?(value)
    !!(value =~ valid_email_regex)
  end

  def self.valid_email_regex
    /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  end
end
