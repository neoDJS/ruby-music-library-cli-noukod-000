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
                            Song.all.each_with_index{|s, i| puts "#{i+1}. #{s.to_s}"} # complete
                          }
  			 },
          "list_artists" => {label: "To list all of the artists in your library, enter 'list artists'.",
  			        bloc: define_method("list_artists"){
                            Artist.all.each_with_index{|a, i| puts "#{i+1}. #{a.name}"} # complete
  												}
  			 },
          "list_genres" => {label: "To list all of the genres in your library, enter 'list genres'.",
  			        bloc: define_method("list_genres"){
                            Genres.all.each_with_index{|g, i| puts "#{i+1}. #{g.name}"} # complete
  												}
  			 },
          "list_artist" => {label: "To list all of the songs by a particular artist, enter 'list artist'.",
  			        bloc: define_method("list_songs_by_artist"){
                            puts "Please enter the name of an artist:"
                            #artName = getName
  												}
  			 },
          "list_genre" => {label: "To list all of the songs of a particular genre, enter 'list genre'.",
  			        bloc: define_method("list_songs_by_genre"){
  												}
  			 },
          "play_song" => {label: "To play a song, enter 'play song'.",
  			                  bloc: define_method("play_song"){

  												}
  			 },
          "exit" => {label: "To quit, type 'exit'.",
  			        bloc: define_method("exit"){
                        #puts "Done !"
  											 return true
  										 }
  			 }
  }

  def call
    count = 0
    opt = "list"
  		puts "Welcome to your music library!" #if count < 1
    while opt != "exit"
  		Menu.each{|k, o| puts "#{o[:label]}" }
      puts "What would you like to do?"

  		opt = self.getCmd
      opt = opt.downcase.gsub(" ", "_")
  		send Menu[opt][:bloc]
      binding.pry

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
  	cmd = ""
  	m = /\A[a-zA-Z\s\d]+\z/
  	while !cmd.validate(m)
  		#puts "Please write your selected command#{count>0? " again" : ""} :"
  		cmd = gets.strip
  		#count += 1
  	end
  	cmd
  end
end
