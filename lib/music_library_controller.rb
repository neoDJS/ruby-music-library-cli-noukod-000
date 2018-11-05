require 'pry'
class MusicLibraryController


  attr_accessor :lpath
  attr_reader :musicImp
  def initialize(path="./db/mp3s")
    @lpath = path
    @musicImp = MusicImporter.new(@lpath)
    @musicImp.import
  end




  Menu ={ "list_songs" => {label: "To list all of your songs, enter 'list songs'.",
  			        bloc: define_method("list_songs"){
                            Song.all.sort{|s1, s2| s1.name <=> s2.name}.each_with_index{|s, i| puts "#{i+1}. #{s.to_s}"} # complete
                          }
  			 },
          "list_artists" => {label: "To list all of the artists in your library, enter 'list artists'.",
  			        bloc: define_method("list_artists"){
                            Artist.all.sort{|a1, a2| a1.name <=> a2.name}.each_with_index{|a, i| puts "#{i+1}. #{a.name}"} # complete
  												}
  			 },
          "list_genres" => {label: "To list all of the genres in your library, enter 'list genres'.",
  			        bloc: define_method("list_genres"){
                            Genre.all.sort{|g1, g2| g1.name <=> g2.name}.each_with_index{|g, i| puts "#{i+1}. #{g.name}"} # complete
  												}
  			 },
          "list_artist" => {label: "To list all of the songs by a particular artist, enter 'list artist'.",
  			        bloc: define_method("list_songs_by_artist"){
                            puts "Please enter the name of an artist:"
                            #binding.pry
                            artName = self.getName
                            artist = Artist.find_by_name(artName)
                            artist.songs.sort{|s1, s2| s1.name <=> s2.name}.each_with_index{|s, i| puts "#{i+1}. #{s.to_sa}"} if artist # complete
                            # Artist.find_by_name(artName = getName).songs.sort{|s1, s2| s1.name <=> s2.name}.each_with_index{|s, i| puts "#{i+1}. #{s.to_sa}"} if Artist.find_by_name(artName) # complete
  												}
  			 },
          "list_genre" => {label: "To list all of the songs of a particular genre, enter 'list genre'.",
  			        bloc: define_method("list_songs_by_genre"){
                            puts "Please enter the name of a genre:"
                            genName = self.getName
                            genre = Genre.find_by_name(genName)
                            genre.songs.sort{|s1, s2| s1.name <=> s2.name}.each_with_index{|s, i| puts "#{i+1}. #{s.to_sg}"} if genre # complete
                            # Genre.find_by_name(genName = getName).songs.sort{|s1, s2| s1.name <=> s2.name}.each_with_index{|s, i| puts "#{i+1}. #{s.to_sg}"} if Genre.find_by_name(genName) # complete
  												}
  			 },
          "play_song" => {label: "To play a song, enter 'play song'.",
  			                  bloc: define_method("play_song"){
                            puts "Which song number would you like to play?"
                            songNum = self.getSong
                            Song.all.sort{|s1, s2| s1.name <=> s2.name}.each_with_index{|s, i| puts s.play if songNum.to_i == i+1} if !Song.all.empty? && (1..Song.all.count).cover?(songNum.to_i)
  												}
  			 },
          "exit" => {label: "To quit, type 'exit'.",
  			        bloc: define_method("exit"){
                        #puts "Done !"
  											 return true
  										 }
  			 }
  }

  def self.menu_list_songs_by_artist
    send Menu["list_artist"][:bloc]
  end

  def call
    count = 0
    opt = "list"
  		puts "Welcome to your music library!" #if count < 1
    while opt != "exit"
  		Menu.each{|k, o| puts "#{o[:label]}" }
      puts "What would you like to do?"

  		opt = self.getCmd
      opt = opt.downcase.gsub(" ", "_")

      #binding.pry

  		send Menu[opt][:bloc] if Menu[opt]

  		count += 1
  	end
  end

  def getCmd
  	count = 0
  	cmd = ""
  	m = /\A[a-zA-Z\s]+\z/
  	while !cmd.validate(m)
  		#puts "Please write your selected command#{count>0? " again" : ""} :"
  		cmd = gets.strip
  		#count += 1
  	end
  	cmd
  end

  def getName
  	count = 0
  	name = ""
  	m = /\A[a-zA-Z\s\d#-]+\z/
  	while !name.validate(m)
  		#puts "Please write your selected command#{count>0? " again" : ""} :"
  		name = gets.strip
  		#count += 1
  	end
  	name
  end

  def getSong
  	count = 0
  	cInt = ""
  	m = /\A[a-zA-Z\s\d#-]+\z/  # /\A\d+\z/
  	while !(cInt.validate(m)) # && (from..to).cover?(cInt.to_i))
  		# puts "Invalid number.\n Please choose again : " if count>0
  		cInt = gets.strip
  		# count += 1
  	end
  	cInt.to_i
  end
end
