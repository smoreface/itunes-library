module ITunes
  class Track
    def initialize(library, properties)
      @library    = library
      @properties = properties
    end

    def to_hash
      @properties
    end

    def [](key)
      @properties[key]
    end

    def id
      self['Track ID']
    end

    def persistent_id
      self['Persistent ID']
    end

    def name
      self['Name']
    end

    def artist
      self['Artist']
    end

    def album
      self['Album']
    end

    def number
      self['Track Number']
    end
    
    def genre
      self['Genre']
    end

    def bpm
      self['BPM']
    end

    def year
      self['Year']
    end

    def composer
      self['Composer']
    end

    def season_number
      self['Season']
    end

    def episode_number
      self['Episode Order']
    end

    def date_added
      self['Date Added']
    end

    def last_played_at
      self['Play Date UTC']
    end

    def rating
      self['Rating']
    end

    def rating_computed?
      self['Rating Computed'] || false
    end

    def album_rating
      self['Album Rating']
    end

    def album_rating_computed?
      self['Album Rating Computed'] || false
    end
    
    def play_count
      self['Play Count'] || 0
    end

    def total_time
      self['Total Time'] / 1000
    end

    def kind
      self['Kind']
    end

    def bit_rate
      self['Bit Rate']
    end
    
    def sample_rate
      self['Sample Rate']
    end
    
    def artwork_count
      self['Artwork Count']
    end

    def location
      self['Location']
    end

    def location_path
      return nil unless location
      uri_parser.unescape(location).gsub('file://localhost', '')
    end

    def audio?
      !video?
    end

    def video?
      self['Has Video'] || false
    end

    def movie?
      self['Movie'] || false
    end

    def tv_show?
      self['TV Show'] || false
    end

    def podcast?
      self['Podcast'] || false
    end

    def audiobook?
      kind =~ /Audible/ ? true : false
    end

    def unplayed?
      self['Unplayed'] == true || play_count == 0
    end

    def played?
      !unplayed?
    end

    def inspect
      "#<#{self.class.name} name=#{name.inspect}>"
    end

    private

    def uri_parser
      # choose appropriate URI class for Ruby 1.9/1.8
      @uri_parser ||= URI.const_defined?(:Parser) ? URI::Parser.new : URI
    end
  end
end