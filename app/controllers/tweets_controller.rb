class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  post "/tweets" do
    # {"content"=>"tweet!!!", "submit"=>""}
    if logged_in?
      if params[:content] != ""
        @user = current_user
        @user.tweets << Tweet.create(content: params[:content])
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end
  end

  get "/tweets/new" do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    #{"id"=>"1"}
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  patch "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id != session[:user_id]
        redirect "/tweets"
      else
        if params[:content] != ""
          @tweet.content = params[:content]
          @tweet.save
        end
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  delete "/tweets/:id" do
    # {"_method"=>"DELETE", "id"=>"1"}
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @tweet.destroy if @tweet.user_id == session[:user_id]
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
end
