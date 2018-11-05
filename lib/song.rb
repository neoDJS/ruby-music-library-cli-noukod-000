class Song
  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre
  def initialize(title, art = nil, genre=nil)
    @name = title
    self.artist = art if !art.nil?
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def to_s
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
  end

  def to_sa
    "#{self.name} - #{self.genre.name}"
  end

  def to_sg
    "#{self.artist.name} - #{self.name}"
  end

  def play
    "Playing #{self.name} by #{self.artist.name}"
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) if !artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.new_from_filename(filename="")
    tab = filename.split(" - ")
    new_s = Song.new(tab[1], Artist.find_or_create_by_name(tab[0]), Genre.find_or_create_by_name(tab[2].chomp(".mp3")))
    #new_s.artist.add_song(new_s)
    new_s
  end

  def self.create_from_filename(filename="")
    new_s = Song.new_from_filename(filename)
    new_s.save
    new_s
  end
end
