
class Song
	attr_reader :name
	attr_reader :artist
	attr_reader :genre
	attr_reader :subgenre
	attr_accessor :tags

  def initialize(data_string) 
   set_song_properties(data_string)
  end 

  def set_song_properties(values)
    values = split_strip(values) 
  	set_name_and_artist(values[0, 2])
  	set_genres(values[2])
    set_tags(values[3])
    add_genres_as_tags()
  end

  def split_strip(string)
  	Array.new.tap do |arr| 
  	string.split(".").each{|el| arr << el.strip}
  	end	
  end

  def set_tags(string)
  	if string == nil
  		@tags = []
  	else
  	Array.new.tap do |arr|
    	if string.include?(",")
    	tags = string.split(",")
    	tags.each {|tag| arr << tag.strip}
    	else
    	arr << string.strip	
    	end
  	@tags = arr
    end
   end
  end
  
  def set_name_and_artist(values)
    @name = values[0]
    @artist = values[1]
  end

  def set_genres(string)
    if string.include?(",")
    genres = string.split(",")
    @genre = genres[0].strip
    @subgenre = genres[1].strip  
    else 	
    @genre = string
    @subgenre = nil
    end
  end

  def add_genres_as_tags()
     @tags.push(@genre.downcase)  
     @tags.push(@subgenre.downcase) if @subgenre != nil
  end

  def search(criteria)
    criteria.all? do |key, value|
   case key
    when :filter then value.call(self)
    when :tags then check_tags(value)
      else
         song_value = self.send(key)
         if is_a_negation_tag(value)
           value.chop != song_value
         else 
          value == song_value
         end
       end
    end
  end

  def check_tags (tags)
      if tags.kind_of?(Array)
        tags.all? {|tag| check_tag(tag)}
      else 
        check_tag(tags)
      end
  end

  def is_a_negation_tag(string)
    string[string.length - 1] == '!'
  end

  def song_contains_tag(tag)
    @tags.flatten.any? { |element| element == tag }
  end

 def check_tag(tag)
  if is_a_negation_tag(tag)
      !song_contains_tag(tag.chop)
  else 
      song_contains_tag(tag)
  end 
end

def add_tags(hash)
    hash.each {|key, value| @tags.push(value).flatten if @artist == key}
end
 
end

class Collection

    attr_reader :songs

	def initialize(songs_data, hash)
	@songs = map_text_to_song_objects(songs_data.lines)
	@songs.each{|song| song.add_tags(hash)}
	end

	def map_text_to_song_objects(string_array)
		 string_array.map{|line| Song.new(line)}	
	end
  
  def find(criteria)
    filtered_songs = @songs.select {|song| song.search(criteria)}
     puts filtered_songs.map(&:name).join("\n")
  end
end


	# def find(hash_with_criteria)
	# 	#hash_with_criteria.each {|k,v| puts k, v}
	# 	#hash_with_criteria.each {|key, value| @songs.select {|song| puts song.send(key)}} 
	# 	collection = []
	# 	hash_with_criteria.each {|k,v| @songs.each {|song| 
	# 		should_add_song = if v.kind_of?(Array)
 #        song.check_tags(v)
 #      else
 #        song.check_tag(v)
 #      end

 #      if should_add_song
	# 			collection.push(song)
	# 		end
	# 		}
	# 	}
	# 	#collection.map(&:name).join("\n")
	# end


#song = Song.new("My Favourite Things. John Coltrane. Jazz, Bebop.  popular, cover")
#puts song.search("genre", "jazz")
#puts song.search(filter: ->(song) { song.name.start_with?('My') })
#song.add_more_tags()
#puts song.song_contains_tag("popular")
#puts song.tags
# song = Song.new(" Alabama.                      John Coltrane.      Jazz, Avantgarde.   melancholic")
# puts song.name
# puts song.author
# puts song.genre
# puts song.subgenre
# puts song.tags
# puts song.tags
#  puts song.tags * " "
#  puts song.tags.any? {|element| element == "popular"}
input = "My Favourite Things.          John Coltrane.      Jazz, Bebop.        popular, cover
Greensleves.                  John Coltrane.      Jazz, Bebop.        popular, cover
Alabama.                      John Coltrane.      Jazz, Avantgarde.   melancholic
Acknowledgement.              John Coltrane.      Jazz, Avantgarde
Afro Blue.                    John Coltrane.      Jazz.               melancholic
'Round Midnight.              John Coltrane.      Jazz
My Funny Valentine.           Miles Davis.        Jazz.               popular
Tutu.                         Miles Davis.        Jazz, Fusion.       weird, cool
Miles Runs the Voodoo Down.   Miles Davis.        Jazz, Fusion.       weird
Boplicity.                    Miles Davis.        Jazz, Bebop
Autumn Leaves.                Bill Evans.         Jazz.               popular
Waltz for Debbie.             Bill Evans.         Jazz
'Round Midnight.              Thelonious Monk.    Jazz, Bebop
Ruby, My Dear.                Thelonious Monk.    Jazz.               saxophone
Fur Elise.                    Beethoven.          Classical.          popular
Moonlight Sonata.             Beethoven.          Classical.          popular
Pathetique.                   Beethoven.          Classical
Toccata e Fuga.               Bach.               Classical, Baroque. popular
Eine Kleine Nachtmusik.       Mozart.             Classical.          popular, violin
Goldberg Variations.          Bach.               Classical, Baroque"

hash = {
  'John Coltrane' => %w[saxophone],
  'Bach' => %w[piano polyphony],
}

# hash.each {|k,v| puts k}
 collection = Collection.new(input, hash)
#puts collection.songs.map(&:name).join("\n")
#puts collection.find(tags: 'popular', artist: 'John Coltrane')
#puts collection.find(filter: ->(song) { song.name.include?('Leaves')})
puts collection.find(artist: 'Miles Davis', filter: ->(song) {song.name.include?('u')}, tags: %w[weird bebop!], subgenre: 'Fusion')
#collection.print_tags("Bach")
# 
# puts collection.songs
# puts collection.find(tags: %w[jazz piano!], tags: %w[jazz piano!])
# puts collection.find(tags: 'popular', artist: 'John Coltrane')
# puts collection.find(tags: 'popular')
# puts collection.find(tags: %w[jazz piano!])

 #puts collection.find(tags: %w[jazz piano!], artist: 'John Coltrane')
# arr = input.split("\n")

# def foo(tags)
#   tags.any? do |tag|
#   if tag == ""
#     true
#   else
#     false
#   end
# end
#  