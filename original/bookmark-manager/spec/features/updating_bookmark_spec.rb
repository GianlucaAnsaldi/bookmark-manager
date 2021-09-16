feature 'Updating a bookmark' do
  scenario 'A user can update an existing bookmark' do
    bookmark = Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
    visit '/bookmarks'
    expect(page).to have_link('Facebook', href: 'http://www.facebook.com')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"
    fill_in('url', with: 'http://www.google.com')
    fill_in('title', with: 'Google')
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Facebook', href: 'http://www.facebook.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end