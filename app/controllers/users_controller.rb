class UsersController < ApplicationController
  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/create_user"
    end
  end

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
    if logged_in?
      redirect "/tweets"
    else
      erb :"users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/tweets"
    end
  end

  get "/users/:slug" do
    @user = User.find_by(username: slug.split("-").join(" "))

    if @user
      @tweets = Tweet.find_by( :all, user_id: @user.id)
      erb :"users/show"
    else
      redirect "/login"
    end
  end
end
