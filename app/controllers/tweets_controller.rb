class TweetsController < ApplicationController

  get "/tweets" do
    redirect to("/login") unless session[:user_id].present?
    @tweets = Tweet.all
    erb :"tweets/index"
  end

  get "/tweets/new" do
    redirect to("/login") unless session[:user_id].present?

    erb :"tweets/new"
  end

  post "/tweets" do
    if params[:content].empty?
      redirect to "/tweets/new"
    else
      Tweet.create(content: params[:content], user: Helpers.current_user(session))

      redirect to("/tweets")
    end
  end

  get "/tweets/:id" do
    redirect to("/login") unless session[:user_id].present?
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show"
  end

  get "/tweets/:id/edit" do
    redirect to("/login") unless session[:user_id].present?
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/edit"
  end

  patch "/tweets/:id" do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find(params[:id])
      tweet.update(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    end
  end

  delete "/tweets/:id" do
    redirect to("/login") unless session[:user_id].present?
    tweet = Tweet.find(params[:id])
    redirect to "/tweets/#{tweet.id}" unless Helpers.current_user(session) == tweet.user
    tweet.destroy
    erb :"/tweets/index"
  end
end
