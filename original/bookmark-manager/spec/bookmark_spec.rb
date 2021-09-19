require 'bookmark'
require 'comment'
require 'database_helpers'

describe Bookmark do
  let(:comment_class) { double(:comment_class) }
  
  describe '.all' do

    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://example.org', title: 'Test Bookmark')
      persisted_data = persisted_data(id: bookmark.id, table: 'bookmarks')

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.url).to eq 'http://example.org'
      expect(bookmark.title).to eq 'Test Bookmark'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      bookmark = Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(bookmark).not_to be_a Bookmark
    end
  end

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
      
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'updates an existing bookmark' do
      bookmark = Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.amazon.com', title: 'Amazon')
    
      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Amazon'
      expect(updated_bookmark.url).to eq 'http://www.amazon.com'
    end
  end

  describe '.find' do
    it 'returns the requested bokkmark object' do
      bookmark = Bookmark.create(url: 'http://www.facebook.com', title: 'Facebook')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.url).to eq 'http://www.facebook.com'
      expect(result.title).to eq 'Facebook'
    end
  end

  describe '#comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      allow(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class)
    end
  end
end