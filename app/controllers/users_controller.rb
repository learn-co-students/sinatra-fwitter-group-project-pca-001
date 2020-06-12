class UsersController < ApplicationController
  get "/users/:slug" do
    @user = Helpers.current_user(session)
    @tweets = @user.tweets

    erb :"users/show"
  end
end
