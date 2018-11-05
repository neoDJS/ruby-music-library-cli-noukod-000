class Artist
  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
  @@all = []
  attr_accessor :name
  attr_reader :songs
  def initialize(name = "")
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.artist = self if song.artist.nil?
  end

  def add_songs(songs)
    songs.each { |song| add_song(song) }
  end

  def genres
    self.songs.map do |s|
      s.genre
    end.uniq
  end
end
