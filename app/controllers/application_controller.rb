class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from OAuth2::Error do |e|
  	if e.responce.status == 401
  		session[:user_id] = nil
  		session[:access_token] = nil
  		redirect_to root_url, allert: "Access token expired, try signin again."
  	end
  end

  

  def after_sign_in_path_for(resource_or_scope)
    user_path(current_user)
  end

  private
  	
  	def auth_client
  		@oauth_client ||= OAuth2::Client.new(ENV["OAUTH_ID"], ENV["OAUTH_SECRET"], site: "http://localhost:3001")
  	end

  	def access_token
  		if session[:access_token]
  			@access_token ||= OAuth2::AccessToken.new(auth_client, session[:access_token])
  		end
  	end

  	def current_user
  		@current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  	end

  	helper_method :current_user

end
