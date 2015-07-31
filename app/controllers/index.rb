get '/' do
  @post = Post.all
  @tags = Tag.all
  erb :index
end

get '/new' do
  @tags = Tag.all
  erb :new_post
end

post '/create' do
  @post = Post.new(params[:post])
  tags = params[:tag].split(", ")
  if @post.save
    tags.each {|tag| @post.tags << Tag.find_or_create_by(name: tag)}
    redirect "/show/#{@post.id}"
  else
    redirect "/"
  end
end

get '/show/:id' do
  @post = Post.find(params[:id])
  @tags = @post.tags
  erb :show_post
end

get '/show/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit
end

put '/posts/:id' do

  @post = Post.find(params[:id])
  @update = @post.update(body: params[:post][:body])
  redirect "/show/#{@post.id}"
end

delete '/posts/:id/delete' do
  @post = Post.find(params[:id])
  @delete = @post.destroy

  redirect "/"
end

get '/show/tags/:t_id' do
  @tags = Tag.find(params[:t_id])
  @posts = @tags.posts
  erb :show_tags
end



# post = Post.first
# tag = Tag.first

# #1 for associating an existing tag
# PostTag.create(post_id: post.id, tag_id: tag.id)
# #2
# PostTag.create(post: post, tag: tag)
# #3
# post.tags << tag
# tag.posts << post

# #1 for making a new tag name
# post.tags.create(name: "something")


# #2 for making a new tag namezzzz
# Tag.create(name: "something")
# post.tags << tag