require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models/post.rb'

class Router < Sinatra::Base
  # enable automatic reloading in development
  configure :development do
    register Sinatra::Reloader
  end

  # get root route...or all posts
  get '/' do
    {message: 'Welcome Sinatra fan!'}.to_json
  end

  # fetch individual post
  get '/posts/:id' do
    Post.where(id: params['id']).first.to_json
  end

  # create a post
  post '/posts' do
    post = Post.new(params)
   
    if post.save
      post.to_json
    else
      halt 422, post.errors.full_messages.to_json
    end
  end
end
