shared_examples 'not authenticated' do
  it 'redirects to login page' do
    visit '/'
    expect(page).to have_current_path('/my/users/login')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
