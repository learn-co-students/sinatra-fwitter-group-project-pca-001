class TweetsController < ApplicationController
  get "/tweets" do
    redirect "/login" if session[:user_id].nil?

    @user = Helpers.current_user(session)
    @tweets = Tweet.all

    erb :"/tweets/index"
  end

  get "/tweets/new" do
    redirect "/login" if session[:user_id].nil?

    erb :"/tweets/new"
  end

  post "/tweets" do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      tweet = Tweet.create(params)
      tweet.user = Helpers.current_user(session)
      redirect "/tweets/#{tweet.id}" if tweet.save
    end
  end

  get "/tweets/:id" do
    redirect "/login" if session[:user_id].nil?

    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show"
  end

  get "/tweets/:id/edit" do
    redirect "/login" if session[:user_id].nil?
    @tweet = Tweet.find(params[:id])

    erb :"/tweets/edit" if @tweet.user == Helpers.current_user(session)
  end

  patch "/tweets/:id" do
    redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?

    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
  end

  delete "/tweets/:id" do
    redirect "/login" if session[:user_id].nil?

    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user == Helpers.current_user(session)
    redirect "/tweets"
  end
end
