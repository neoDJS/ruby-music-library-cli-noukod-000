class Genre
  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
  @@all = []
  attr_accessor :name, :songs
  def initialize(title="")
    @name = title
    @songs = []
  end

  def self.all
    @@all
  end

  # def songs
  #   Song.all.select do |s|
  #     s.genre == self
  #   end
  # end

  def artists
    self.songs.map do |s|
      s.artist
    end.uniq
  end
end
