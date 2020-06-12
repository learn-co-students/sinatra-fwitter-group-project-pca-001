class TweetsController < ApplicationController

  get "/tweets" do
    if Helper.logged_in?(session)
    @user = Helper.current_user(session)
    @tweets = Tweet.all
    erb :"/tweets/tweets"
    else
    redirect to "/login"
    end
  end

  # get "/tweets" do
  #   if Helper.logged_in?(session)
  #     @user = Helper.current_user(session)
  #     @tweets = Tweet.all
  #     erb :"tweets/tweets"
  #   else
  #     redirect "/login"
  #   end
  # end

  get "/tweets/new" do
    if Helper.logged_in?(session)
      @user = Helper.current_user(session)
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

    # post "/tweets" do
    #   if !Helper.logged_in?(session)
    #     redirect to "/login"
    #   end
    #   @user = Helper.current_user(session)
    #   @tweet = Tweet.new(content: params["content"], user_id: @user.id)
    #   if @tweet.valid?
    #     @tweet.save
    #     redirect to "/tweets"
    #   else
    #     redirect to "tweets/new"
    #   end
    # end

  post "/tweets" do
    if Helper.logged_in?(session)
      if params[:content] != ""
        @user = Helper.current_user(session)
        @user.tweets << Tweet.create(content: params[:content])
        redirect "/tweets"
      else
        redirect "/tweets/new"
      end
    else
      redirect "/login"
    end
  end

  get "/tweets/:id" do
    if !Helper.logged_in?(session)
      redirect to "/login"
    end
    @tweet = Tweet.find(params[:id])
    erb :"/tweets/show_tweets"
  end

  get "/tweets/:id/edit" do
    if !Helper.logged_in?(session)
      redirect to "/login"
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user == Helper.current_user(session)
      erb :"/tweets/edit_tweets"
    else
      redirect to "/login"
    end
  end

  patch "/tweets/:id" do
    if Helper.logged_in?(session)
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
    if Helper.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id != session[:user_id]
        redirect "/tweets"
      else
        @tweet.destroy if @tweet.user_id == session[:user_id]
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end
end
