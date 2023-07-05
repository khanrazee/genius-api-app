class SongController < ApplicationController
  def index
    response = FetchSongs.call(artist_name: params[:name])
    @songs, @error = response.success? ? [response.songs, nil] : [[], response.error]

    set_flash_messages
  end

  private

  def set_flash_messages
    flash.now[:notice] = "Songs fetched successfully!" if @songs.any?
    flash.now[:error] = "Error fetching songs." if @error
  end
end
