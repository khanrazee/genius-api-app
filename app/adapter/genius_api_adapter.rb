class GeniusApiAdapter
  RETRY_LIMIT = 3

  def initialize
    Genius.access_token = ENV['ACCESS_TOKEN']
  end

  def fetch_songs_by_artist_name(artist_name)
    with_retry_block do
      Genius::Song.search(artist_name)
    end
  end

  private

  def with_retry_block
    @retry_attempts ||= 0

    sleep(2) unless Rails.env.test? || @retry_attempts.zero?

    yield if block_given?

  rescue StandardError => e
    @retry_attempts += 1
    retry if @retry_attempts < RETRY_LIMIT
    Rails.logger.error("Error Fetching songs: #{e.inspect}")
  end
end
