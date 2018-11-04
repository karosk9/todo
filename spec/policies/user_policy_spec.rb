require 'rails_helper'

describe UserPolicy, type: :policy do
  subject { UserPolicy.new(user, other_user) }
  let(:other_user) { create(:user) }

  context 'current user has admin role' do
    let(:user) { create(:user, role: 'admin') }

    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:edit) }
    it { is_expected.to permit(:destroy) }
  end

  context 'current_user is owner of the account' do
    let(:user) { other_user }

    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:edit) }
    it { is_expected.to permit(:destroy) }
  end

  context 'current user is not owner of the account' do
    let(:user) { create(:user) }

    it { is_expected.not_to permit(:update) }
    it { is_expected.not_to permit(:update) }
    it { is_expected.not_to permit(:edit) }
  end



end
