class Social_network
  
  attr_accessor :network
  
  def initialize()
  @network = {}
  end

 def add_panda(panda)
  if has_panda?(panda)
    raise new PandaAlreadyThere, "Panda already exists in the network"
  else
	@network[panda] = []
  end
 end

 def has_panda?(panda)
	 @network.has_key?(panda)
 end

 def are_friends?(panda1,panda2)
 	 @network[panda1].include?(panda2)
 end

 def make_friends(panda1, panda2)
  if !has_panda?(panda1)
     @network[panda1] = []
  end
  if !has_panda?(panda2)
     @network[panda2] = []
  end 
  if are_friends?(panda1, panda2)
    raise new PandasAlreayFriends, "These pandas are already friends"
  else
    @network[panda1] << panda2
    @network[panda2] << panda1
  end
 end

 def friends_of(panda)
  if !has_panda?(panda)
      false
  else
  @network[panda]
  end
 end



  # def find_connection_level(panda1, panda2)
   
  #   queue = Queue.new
  #   visited = []
  #   queue << [0, panda1]
  #   visited << panda1
  #   while !queue.empty?
  #     level, panda = queue.pop
  #      return level if are_friends?(panda, panda2)
         
  #      end
  #      friends_of(panda).each do |friend| 
  #       if !visited.include? friend
  #         queue << [level + 1, friend]
  #         visited << friend
  #       end
  #      end
  #   end
  #   return -1
  # end
  
  def are_connected(panda1, panda2)
     find_connection_level(panda1, panda2) > 0
    
  end

  # def how_many_gender_in_network(desired_level, panda, gender)
  #   count = 0
  #   queue = Queue.new
  #   visited = []
  #   queue << [0, panda]
  #   visited << panda 
  #   while !queue.empty?
  #     level, panda = queue.pop
  #     break if level == desired_level
  #     friends_of(panda).each do |friend|s
  #       if !visited.include? friend
  #         if friend.gender.eql? gender
  #           count += 1
  #         end
  #         queue << [level + 1, friend]
  #         visited << panda        
  #       end 
  #     end
  #     count
  #   end
  #  end

  def save_file()
    file = File.new("save_panda_network.txt", "w+")
    @network.each{|k,v| 
    file.puts "#{k} has friends: "
    v.each {|value|
    file.puts value
    }} 
    # file.puts "\n" 
    file.close
  end

  def get_pandas_identity(line)
  # name_pattern = "(?<=name=\s)\w+" 
    begin
      name = line.scan(/(?<=name=)(.*?)(?=,|\s)/).first[0]
      email = line.scan(/(?<=email=)(.*?)(?=,|\s)/).first[0]
      gender = line.scan(/(?<=gender=)(.*?)(?=,|\s)/).first[0]
      panda = PandaWrapper.new(Panda.new(name, gender, email), line.include?('friends'))
      rescue WrongPandaFormat => e
        e.message
    end
  end
 
  def save_json(path)
    require 'json'
    file = File.new(path, "w+")
    file.puts @network.to_json
    file.close
  end

  def load_json(path)
    # require 'json'
    file = File.open(path, "r")
    data = file.read
    file.close
    hash = JSON.parse(data)  
  end

  def save_yaml(path)
    require 'yaml'
    file = File.new(path, "w+") 
    file.puts @network.to_yaml
    file.close   
  end

  def load_yaml(path)
    file = File.open(path, "r")
    data = file.read
    hash = YAML.load(data)
    file.close
    hash
  end

  def save_xml(path)
    require 'nokogiri'
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.network {
        @network.each do |k, v|
        xml.panda {
          xml.name k.name
          xml.email k.email
          xml.gender k.gender
           xml.friends {
            v.each do |fr|
              xml.friend {
              xml.id_ k.name
              xml.name fr.name
              xml.email fr.email
              xml.gender fr.gender
              }
            end 
          }
        }
      end
      }
   end
     file = File.new(path, "w+")
     file.write(builder.to_xml)
     file.close
   end

   def load_xml(path)
    require 'nori'
     file = File.open(path, "r")
     doc = Nokogiri::XML(file)
     file.close
     hash = Nori.new.parse(doc.to_s)
     puts hash
   end
    # Nokogiri::XMLBuilder.build(file)
 
  def load_file()
    require 'pathname'
    pn = Pathname.new(pathname)
    file_format = pn.extname
    pandas_network = {}
    file = File.open("save_panda_network.txt", "r")
    data = file.read.lines
    current_panda = nil
    data.each {|line| 
      panda = get_pandas_identity(line)
      if panda.friends
        current_panda = get_pandas_identity(line).panda
        pandas_network[current_panda] = []
      else
        pandas_network[current_panda] << panda.panda
      end
    }
    puts pandas_network
  end
end

class PandaWrapper
  attr_reader :panda, :friends

  def initialize(panda, friends)
    @panda = panda
    @friends = friends
  end

  def should_add_friends?
    @friends
  end
end

class PandaAlreadyThere < StandardError
end

class PandasAlreayFriends < StandardError
end

class WrongPandaFormat < StandardError
  def message
    puts "Panda is not in the right format."
  end
end

class Panda

	@friends = []
  attr_accessor :name, :gender, :email
	def initialize(name, gender, email)
  	@name = name
  	@gender = gender
  	@email = email
	end

	def to_s
   	"name=#{@name}, gender=#{@gender}, email=#{@email}"
  end

 def hash
 	to_s.hash
 end

 def ==(other)
 	 hash == other.hash
  end
 
 # alias_method :eql?,:==
 # end
end





network = Social_network.new
maria = Panda.new("Maria", "f", "mshahpazova@gmail.com")
iva = Panda.new("Iva", "f", "iva@hotmail.com")
nikola = Panda.new("Nikola", "m", "nshahpazov@gmail.com")
krisi = Panda.new("Krisi", "f", "krisi@hotmail.com")
ivan = Panda.new("Ivan", "m", "ivan@abv.bg")
geri = Panda.new("Geri", "f","geri@yahoo.com")
petya = Panda.new("Petya", "f", "petya@hotmail.com")
network.make_friends(ivan, krisi)
network.make_friends(krisi, nikola)
network.make_friends(nikola, iva)
network.make_friends(petya, geri)
# network.add_panda(maria)
# network.add_panda(iva)
# network.add_panda(nikola)
network.make_friends(maria, iva)
network.make_friends(maria, nikola)
# network.make_friends(ivan, krisi)
network.save_xml("panda_network.xml")
network.load_xml("panda_network.xml")
# network.save_xml("panda_network.xml")
# network.save_json("panda_network.json")
# puts network.load_json("panda_network.json")
 # network.save_yaml ("panda_network.yaml")
 # puts network.load_yaml("panda_network.yaml")
# puts network.find_connection_level(petya, ivan)
 # network.how_many_gender_in_network(2, ivan, "f")
# puts network.find_connection_level(ivan, iva)
# puts network.find_connection_level(ivan, krisi)

# network.make_friends(mar)
# network.find_connection_level(iva, nikola)
 # puts network.has_panda?(maria)
# # puts network.are_friends?(maria, nikola)
# p network.friends_of(maria)
 # network.save_file()
 # network.load_file()









  # def save_file()
  # # http://stackoverflow.com/questions/2777802/how-to-write-to-file-in-ruby
  # file = File.new("save_panda_network.txt", "w+")
  # @network.each{|key,value| file.puts ("anchor key:{#{key}}, value:{#{value}} anchor") }
  # file.close unless file.nil?
  # end

 # def load_file()
 #     file = File.open("save_panda_network.txt", "r")
 #     data = file.read
 #     arr = data.scan(/anchor(.+)anchor/)
 #     arr.each{|el| puts el.to_s}
 #     # arr.each {|match| puts match.to_s.split("value") }
 #     # file.close
 # end
 # def make_friends(panda1, panda2)
 #  if !@network.has_key?(p   anda1)
 #    @network[panda1].push(panda2)
 #  end
  # if !@network.has_key(panda2)
  #   @network[panda2].push(panda1)
  # end 
  #  panda1.friends.push(panda2)
  #  panda2.friends.push(panda1)
 # end
 # end

#  def search_friends(panda1, panda2)
#   panda1.friends.each {|friend| 
#     if are_friends(friend, Panda2)
#      return true;
#     else
#      return false;
#   end}
# end
# def check_level_of_connection(panda1, panda2)
#   count = 0
#   if are_friends(Panda1, Panda2)
#     return 1;
#   end
#   if search_friends(Panda1, Panda2)
#     /////
#   else 
#    panda1.friends.each {|friend| search_friends (friend, Panda2)}
    
# bfs -       # Nesho s panda
      # Za vseki neobhoden sused na panda
      # Dobavqne vuv visited
    #   # Dobavqme vuv queue s level + 1 