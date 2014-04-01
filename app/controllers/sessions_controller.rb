class SessionsController < ApplicationController

  def create
    puts "session details"
    puts session.inspect

    puts "coming to session create with creating user account"
  	auth = request.env["omniauth.auth"]
  	puts auth.inspect
  	puts "--------------------------"
  	info = auth["extra"]["raw_info"]
    session[:user_info] = info
  	user = User.where(provider: auth["provider"], uid: auth["uid"])
  	puts "Existing user #{user.first.inspect}"
  	puts "--------------------------"
  	
  	if user.present?
  		user = user.first
      puts "user exists"
      puts user.inspect

  	else
  		puts "creating new user"
      user = User.create!(name: "#{info["first_name"]} #{info["last_name"]}", country: info["country"], email: info["email"], mobile_number: info["mobile_number"], provider: auth["provider"], uid: auth["uid"] )
  		puts user.inspect
  		puts "------------------------------"
  	end

	  session[:user_id] = user.id
	  puts session[:user_id]
	  puts "--------------"
	  session[:access_token] = auth["credentials"]["token"]

    puts "session details"
    puts session.inspect
     
  	redirect_to root_url
  end

  def destroy

  	session[:user_id] = nil
  	session[:access_token] = nil
  	session.clear

    puts "session details"
    puts session.inspect

    redirect_to root_url
  end

end
