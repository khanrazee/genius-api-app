require 'rails_helper'

RSpec.describe GeniusApiAdapter do
  let(:adapter) { GeniusApiAdapter.new }

  before do
    allow(ENV).to receive(:[]).with('ACCESS_TOKEN').and_return('dummy_access_token')
  end

  describe '#fetch_songs_by_artist_name' do
    let(:artist_name) { 'Artist' }
    let(:songs) { [double(Genius::Song, title: 'Song 1'), double(Genius::Song, title: 'Song 2')] }

    context 'when successful' do
      before do
        allow(Genius::Song).to receive(:search).with(artist_name).and_return(songs)
      end

      it 'returns the songs' do
        adapter.fetch_songs_by_artist_name(artist_name)
      end
    end

    context 'when an error occurs' do
      let(:error) { StandardError.new('Something went wrong') }

      before do
        allow(Genius::Song).to receive(:search).with(artist_name).and_raise(error)
        allow(Rails.logger).to receive(:error)
      end

      it 'logs the error message' do
        adapter.fetch_songs_by_artist_name(artist_name)
        expect(Rails.logger).to have_received(:error).with("Error Fetching songs: #{error.inspect}")
      end
    end
  end
end
