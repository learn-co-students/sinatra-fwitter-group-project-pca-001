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
    Tweet.create(content: params[:content], user: Helpers.current_user(session))

    redirect to("/tweets")
  end
end
