require 'rails_helper'

RSpec.describe SongController, type: :controller do
  describe "GET #index" do
    let(:artist_name) { "Artist" }
    let(:songs) { [double(Genius::Song, title: 'Song 1'), double(Genius::Song, title: 'Song 2')] }
    let(:response) { double(Interactor::Context) }

    before do
      allow(controller).to receive(:params).and_return(name: artist_name)
    end

    context "when songs are successfully fetched" do

      before do
        allow(FetchSongs).to receive(:call).with(artist_name: artist_name).and_return(response)
        allow(response).to receive(:success?).and_return(true)
        allow(response).to receive(:songs).and_return(songs)
      end

      it "assigns the fetched songs to @songs" do
        get :index
        expect(assigns(:songs)).to eq(songs)
      end

      it "assigns nil to @error" do
        get :index
        expect(assigns(:error)).to be_nil
      end

      it "sets flash notice message" do
        get :index
        expect(flash.now[:notice]).to eq("Songs fetched successfully!")
      end
    end

    context "when there is an error fetching songs" do
      let(:error) { "Error message" }

      before do
        allow(FetchSongs).to receive(:call).with(artist_name: artist_name).and_return(response)
        allow(response).to receive(:success?).and_return(false)
        allow(response).to receive(:error).and_return(error)
      end

      it "assigns an empty array to @songs" do
        get :index
        expect(assigns(:songs)).to eq([])
      end

      it "assigns the error message to @error" do
        get :index
        expect(assigns(:error)).to eq(error)
      end

      it "does not set flash notice message" do
        get :index
        expect(flash.now[:notice]).to be_nil
      end

      it "sets flash error message" do
        get :index
        expect(flash.now[:error]).to eq("Error fetching songs.")
      end
    end
  end
end
