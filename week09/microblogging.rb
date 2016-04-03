require 'sinatra'

class Post
  attr_reader :id, :content
  def initialize(id, content)
    @id = id
    @content = content
  end

  def to_s
    "#Post's id: #{@id} Post's content:#{@content}"
  end
end

class Blog
  
  attr_reader :posts
  # @@counter_of_posts = 0
  def initialize()
    @posts = []    
  end

  def create_post(id, content)
      post = Post.new(id, content)
      p post
      add_post(post)
  end
  
  def add_post(post)
    @posts << post
  end

end


$POSTS = []

# blog = Blog.new
# blog.create_post('1', 'It is raining')
# blog.create_post('2', 'It is cold')
  
get '/new' do
  erb :new
end

# p blog.posts.join(" ")
get '/' do
  if !$POSTS.any?
    "There are no posts yet"
  else
    $POSTS.join("\n")
  end
end

get '/post/:id' do
  post = $POSTS.find {|post| post.id == params[:id]}
  if post != nil
    "[#{post}]"
  else
    status 404
    "There is no such post."
  end
end
  
post '/new' do
  if !params[:id] && !params[:content]
     "You need to fill the content and id entries"
  elsif !params[:id]
   "U need to fill the id entry"
  elsif !params[:content]
    "You need to fill the content entry"
  elsif $POSTS.length >= 2
      "Number of posts must not exceed 256."
  else
     $POSTS << Post.new(params[:id], params[:content])
     redirect '/'
  end
end

get '/delete' do
  erb :delete
end

delete '/delete' do
  $POSTS.delete_if{|post| post.id == params[:id]}
   redirect '/'
 end
