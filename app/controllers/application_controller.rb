require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      Helpers.logged_in?(session)
    end

    def current_user
      Helpers.current_user(session)
    end
  end
end
