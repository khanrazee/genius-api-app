class FetchSongs
  include Interactor

  def call
    return context.songs = [] if context.artist_name.blank?

    songs = adaptor.fetch_songs_by_artist_name(context.artist_name)
    context.fail!(error: "No songs found.") unless songs.present?
    context.songs = songs
  end

  private

  def adaptor
    GeniusApiAdapter.new
  end
end
