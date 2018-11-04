require 'rails_helper'

describe 'Show User Profile Page' do
  let!(:user) { create(:user) }
  before do
     login_as(user)
     visit '/'
   end

  context 'user is owner of the profile' do
    it 'visits his own profile page' do
      find("#user-profile").click
      expect(page).to have_current_path("/users/#{user.id}")
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_link("Edit profile")
    end
  end

  context 'user is not owner of the profile' do
    let(:other_user) { create(:user)}
    it "visits someone's profile page" do
      visit "/users/#{other_user.id}"
      expect(page).not_to have_button("Edit profile")
      expect(page).to have_content(other_user.first_name)
      expect(page).to have_content(other_user.last_name)
    end
  end
end
