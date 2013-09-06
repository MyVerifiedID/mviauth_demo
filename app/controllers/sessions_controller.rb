class SessionsController < ApplicationController

  def create
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
  	else
  		user = User.create(name: "#{info["first_name"]} #{info["last_name"]}", country: info["country"], email: info["email"], mobile_number: info["mobile_number"], provider: auth["provider"], uid: auth["uid"] )
  		puts user.inspect
  		puts "------------------------------"
  	end

	  session[:user_id] = user.id
	  puts session[:user_id]
	  puts "--------------"
	  session[:access_token] = auth["credentials"]["token"]

  	redirect_to root_url
  end

  def destroy
  	session[:user_id] = nil
  	session[:access_token] = nil
  	redirect_to root_url
  end

end
