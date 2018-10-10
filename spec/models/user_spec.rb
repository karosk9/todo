require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks) }
  end
end
