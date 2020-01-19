require 'minitest/autorun'
require 'email_validator'

class EmailValidatorTest < Minitest::Test
  def test_valid_email
    assert_equal true,
      EmailValidator.valid?("email@ex.pl")
  end

  def test_not_valid_string
    assert_equal false,
      EmailValidator.valid?("ruby@")
  end
end
