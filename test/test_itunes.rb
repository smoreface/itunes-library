# encoding: UTF-8

require 'itunes/library'

require 'test/unit'

class TestITunes < Test::Unit::TestCase
  include ITunes

  def test_size
    assert_equal 112, library.size
  end

  def test_library_inspect
    assert_equal "#<ITunes::Library size=112>", library.inspect
  end

  def test_playlists
    assert_equal [
      "Library",
      "Music",
      "Movies",
      "Podcasts",
      "Books",
      "Genius",
      "90’s Music",
      "Classical Music",
      "Music Videos",
      "My Top Rated",
      "Recently Added",
      "Recently Played",
      "Top 25 Most Played"
    ], library.playlists.map(&:name)
  end

  def test_playlist_name
    assert_equal "Movies", library.movies.name
  end

  def test_playlist_item_ids
    assert_equal [10981, 11075, 11061, 11068], library.movies.item_ids
  end

  def test_playlist_item_names
    assert_equal ["Casino Royale", "The Dark Knight", "Iron Man", "Ocean's Eleven"], library.movies.items.map(&:name)
  end

  def test_playlist_inspect
    assert_equal "#<ITunes::Playlist name=\"Movies\" size=4>", library.movies.inspect
  end

  def test_track_id
    assert_equal 7944, library.fetch_track(7944).id
  end

  def test_track_persistent_id
    assert_equal "E50BD6C381E767DE", library.fetch_track(7944).persistent_id
  end

  def test_track_artist
    assert_equal "Them Crooked Vultures", library.fetch_track(7944).artist
  end

  def test_track_album
    assert_equal "Them Crooked Vultures", library.fetch_track(7944).album
  end

  def test_track_number
    assert_equal 2, library.fetch_track(7944).number
  end

  def test_track_genre
    assert_equal "Rock", library.fetch_track(7944).genre
  end

  def test_bpm
    assert_equal "192", library.fetch_track(11083).bpm
  end

  def test_track_year
    assert_equal 2009, library.fetch_track(7944).year
  end

  def test_track_composer
    assert_equal "Them Crooked Vultures", library.fetch_track(7944).composer
  end

  def test_track_last_played_at
    assert_equal "2010-04-24T13:33:51+00:00", library.fetch_track(11068).last_played_at.to_s
    assert_equal nil, library.fetch_track(7944).last_played_at # unplayed track
  end

  def test_rating
    assert_equal nil, library.fetch_track(7944).rating
    assert_equal 80, library.fetch_track(10973).rating
  end

  def test_rating_computed
    assert_equal false, library.fetch_track(7944).rating_computed?
    assert_equal true, library.fetch_track(10973).rating_computed?
  end

  def test_album_rating
    assert_equal nil, library.fetch_track(7944).album_rating
    assert_equal 60, library.fetch_track(10973).album_rating
  end

  def test_album_rating_computed
    assert_equal false, library.fetch_track(7944).album_rating_computed?
    assert_equal true, library.fetch_track(10973).album_rating_computed?
  end

  def test_track_play_count
    assert_equal 0, library.fetch_track(7944).play_count
  end

  def test_track_skip_count
    assert_equal 3, library.fetch_track(11084).skip_count
  end

  def test_track_unplayed
    assert_equal true, library.fetch_track(7944).unplayed?
  end

  def test_track_date_added
    assert_equal "2010-04-24T13:24:25+00:00", library.fetch_track(7944).date_added.to_s
  end

  def test_track_location
    expected_location = 'file://localhost/iTunes/iTunes%20Media/Music/Coldplay/Viva%20la%20Vida/10%20Death%20and%20All%20His%20Friends.mp3'
    assert_equal expected_location, library.fetch_track(7405).location
  end

  def test_track_location_path
    expected_path = '/iTunes/iTunes Media/Music/Coldplay/Viva la Vida/10 Death and All His Friends.mp3'
    assert_equal expected_path, library.fetch_track(7405).location_path
  end

  def test_track_comments
    assert_equal "Sub Pop", library.fetch_track(11084).comments
  end

  def test_track_location_path_is_nil_if_location_not_present
    assert_nil library.fetch_track(7400).location_path
  end

  def test_bit_rate
    assert_equal 256, library.fetch_track(7949).bit_rate
  end

  def test_sample_rate
    assert_equal 44100, library.fetch_track(7949).sample_rate
  end

  def test_artwork_count
    assert_equal 1, library.fetch_track(7949).artwork_count
  end

  def test_duration_ms
    assert_equal 246909, library.fetch_track(7944).duration_ms
  end

  def test_audio_track_total_time
    assert_equal 246, library.fetch_track(7944).total_time
  end

  def test_video_track_total_time
    assert_equal 9130, library.fetch_track(11075).total_time
  end

  def test_audiobook_total_time
    assert_equal 27852, library.fetch_track(10999).total_time
  end

  def test_audio_track_kind
    track = library.fetch_track(7944)
    assert_equal "Mind Eraser, No Chaser", track.name
    assert_equal "MPEG audio file", track.kind
    assert_equal true, track.audio?
    assert_equal false, track.video?
  end

  def test_movie_track_kind
    track = library.fetch_track(11075)
    assert_equal "The Dark Knight", track.name
    assert_equal "MPEG-4 video file", track.kind
    assert_equal false, track.audio?
    assert_equal true, track.video?
    assert_equal true, track.movie?
    assert_equal false, track.tv_show?
    assert_equal false, track.podcast?
  end

  def test_tv_show_track_kind
    track = library.fetch_track(11082)
    assert_equal "Crazy Handful of Nothin", track.name
    assert_equal "Protected MPEG-4 video file", track.kind
    assert_equal false, track.audio?
    assert_equal true, track.video?
    assert_equal false, track.movie?
    assert_equal true, track.tv_show?
    assert_equal false, track.podcast?
  end

  def test_audio_podcast_track_kind
    track = library.fetch_track(9879)
    assert_equal "New High-Viscosity Mayo To Aid In American Swallowing", track.name
    assert_equal "MPEG audio file", track.kind
    assert_equal true, track.audio?
    assert_equal false, track.video?
    assert_equal false, track.movie?
    assert_equal false, track.tv_show?
    assert_equal true, track.podcast?
  end

  def test_video_podcast_track_kind
    track = library.fetch_track(9889)
    assert_equal "TEDTalks : Omar Ahmad: Political change with pen and paper - Omar Ahmad (2010)", track.name
    assert_equal "MPEG-4 video file", track.kind
    assert_equal false, track.audio?
    assert_equal true, track.video?
    assert_equal true, track.movie?
    assert_equal false, track.tv_show?
    assert_equal true, track.podcast?
  end

  def test_audiobook_track_kind
    track = library.fetch_track(10999)
    assert_equal "Blink: The Power of Thinking Without Thinking (Unabridged)", track.name
    assert_equal "Audible file", track.kind
    assert_equal true, track.audio?
    assert_equal false, track.video?
    assert_equal false, track.movie?
    assert_equal false, track.tv_show?
    assert_equal false, track.podcast?
    assert_equal true, track.audiobook?
  end

  def test_movie_unplayed
    assert_equal true, library.fetch_track(11075).unplayed?
    assert_equal false, library.fetch_track(11068).unplayed?
  end

  def test_movie_played
    assert_equal false, library.fetch_track(11075).played?
    assert_equal true, library.fetch_track(11068).played?
  end

  def test_tv_show_season_number
    assert_equal 1, library.fetch_track(11082).season_number
  end

  def test_tv_show_episode_number
    assert_equal 6, library.fetch_track(11082).episode_number
  end

  def test_track_inspect
    assert_equal "#<ITunes::Track name=\"Mind Eraser, No Chaser\">", library.fetch_track(7944).inspect
  end

  private
    def library
      @@library ||= load_library
    end

    def load_library
      Library.load(File.expand_path('../fixtures/iTunes Library.xml', __FILE__))
    end
end
