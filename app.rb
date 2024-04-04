require 'sinatra/base'
require 'dotenv/load'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models/post.rb'
require "appsignal/integrations/sinatra"
require 'httparty'

class App < Sinatra::Base
  # enable automatic reloading in development
  configure :development do
    register Sinatra::Reloader
  end

  Thread.new do
    while true do
      start_time = Time.now
      url = 'https://openlibrary.org/search/authors.json?q=clavell'
      $response = HTTParty.get(url)
      duration = (Time.now - start_time) * 1000
      Appsignal.add_distribution_value("fetch_books_duration", duration)
    end
  end

  # home page
  get '/' do
    Appsignal.increment_counter("visits_count", 1) 
    $response.to_json  
  end

  # all posts

  get '/posts' do
    posts = Post.all

    # set Appsignal custom metric
    posts_count = posts.count
    Appsignal.set_gauge("all_posts", posts_count, environment: "development")

    posts.to_json
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

  # update a post

  put '/posts/:id' do
    post = Post.where(id: params['id']).first
   
    if post
      post.title = params['title'] if params.has_key?('title')
      post.body = params['body'] if params.has_key?('body')
      
      if post.save
        post.to_json
      else
        halt 422, post.errors.full_messages.to_json
      end
    end
  end

  # delete a post
  delete '/posts/:id' do
    post = Post.where(id: params['id'])
   
    if post.destroy_all
      {success: "ok"}.to_json
    else
      halt 500
    end
  end
end
