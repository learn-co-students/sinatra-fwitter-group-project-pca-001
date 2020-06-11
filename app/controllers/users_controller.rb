class UsersController < ApplicationController

  get "/signup" do
    if Helper.logged_in?(session)
      redirect to "/tweets"
    end
    erb :"/users/create_user"
  end

  # post "/signup" do
  #   @user = User.create(params)
  #   if @user.valid?
  #     @user.save
  #     session["user_id"] = @user.id
  #     redirect to "/tweets"
  #   else
  #     redirect to "/signup"
  #   end
  # end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get "/login" do
    if Helper.logged_in?(session)
      redirect to "/tweets"
    end
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(username: params["username"])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      # flash[:login_error] = "Wrong Login Info. Please try again."
      erb :"/users/login"
    end
  end

  get "/logout" do
    if Helper.logged_in?(session)
      session.clear
      redirect to "/login"
    else
      redirect to "/tweets"
    end
  end

  get "/users/:slug" do
    @user = User.find_by(username: slug.split("-").join(" "))

    if @user
      @tweets = Tweet.find_by(:all, user_id: @user.id)
      erb :"users/show"
    else
      redirect "/login"
    end
  end

end
