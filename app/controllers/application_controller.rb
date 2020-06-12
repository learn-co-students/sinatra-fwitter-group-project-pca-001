require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    redirect "/tweets" if Helpers.logged_in?(session)

    erb :"/new"
  end

  post "/signup" do
    redirect "/signup" if params[:username].empty? ||
                          params[:password].empty? ||
                          params[:email].empty?

    session[:user_id] = User.create(params).id
    redirect "/tweets"
  end

  get "/login" do
    redirect "/tweets" if Helpers.logged_in?(session)

    erb :login
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    redirect "/login" unless Helpers.logged_in?(session)

    session.destroy
    redirect "/login"
  end
end
