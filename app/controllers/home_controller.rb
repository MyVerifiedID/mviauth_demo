class HomeController < ApplicationController
  def index

  	puts "session details"
    puts session.inspect


    if current_user
    	
    	puts "current_user"
    	puts current_user.inspect

  		redirect_to user_path(current_user)
  	end
  end


end
