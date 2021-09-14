feature 'navigates to the homepage' do
  scenario 'is able to navigate to the homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to the Bookmark Manager'
  end
end
