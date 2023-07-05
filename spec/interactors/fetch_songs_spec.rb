require 'rails_helper'

RSpec.describe FetchSongs do
  describe '#call' do
    let(:genius_adapter) { instance_double('GeniusApiAdapter') }
    let(:artist_name) { 'Artist' }
    let(:songs) { [double(Genius::Song, title: 'Song 1'), double(Genius::Song, title: 'Song 2')] }

    before do
      allow(GeniusApiAdapter).to receive(:new).and_return(genius_adapter)
      allow(genius_adapter).to receive(:fetch_songs_by_artist_name)
    end

    context 'when songs are successfully fetched' do
      before do
        allow(genius_adapter).to receive(:fetch_songs_by_artist_name).and_return(songs)
      end

      let(:fetch_songs) { described_class.call(artist_name: artist_name) }

      it 'sets the songs in the context' do
        expect(fetch_songs).to be_a_success
        expect(fetch_songs.songs).to eq(songs)
      end
    end

    context 'when no songs found' do
      let(:artist_name) { 'test' }
      let(:fetch_songs) { described_class.call(artist_name: artist_name) }

      it 'returns the error' do
        expect(fetch_songs.error).to eq('No songs found.')
      end
    end

    context "when artist_name is blank" do
      let(:artist_name) { '' }
      let(:fetch_songs) { described_class.call(artist_name: artist_name) }

      it 'artist is blank' do
        expect(fetch_songs.songs).to eq([])
      end
    end
  end
end
