class SessionsController < Clearance::SessionsController

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
      sign_in(user)
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      byebug
      if user
        @next = edit_user_path(user)   
        @notice = "User created - confirm or edit details..."
        sign_in(user)
      else
        flash[:notice] = "E-mail exists"
        @next = sign_in_path
      end
    end
    redirect_to @next, :notice => @notice
  end

end