feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
    visit '/bookmarks'
    expect(page).to have_link('Facebook', href: 'http://www.facebook.com')

    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Facebook', href: 'http://www.facebook.com')
  end
end