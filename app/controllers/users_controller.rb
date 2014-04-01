class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
  	puts "coming to show"
  	puts params.inspect

    @user = User.find(params[:id])
  end

end
