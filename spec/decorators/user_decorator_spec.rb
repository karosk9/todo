require 'rails_helper'

describe UserDecorator do
  let(:user) { create(:user).decorate }
  describe '#full_name' do
    it 'displays first and last name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end

    context 'without first and last name' do
      let(:user) { create(:user, first_name: nil, last_name: nil).decorate }
      it { expect(user.full_name).to eq('Incognito user') }
    end
  end

  describe '#data' do
    it { expect(user.data).to eq(user.full_name) }

    context 'user is has no full name' do
      let(:user) { create(:user, first_name: nil, last_name: nil).decorate }
      it { expect(user.data).to eq(user.email) }
    end
  end
end
