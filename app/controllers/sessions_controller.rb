class SessionsController < ApplicationController
  def new
    @openid_url = params[:openid_url]
    session[:return_to] = params[:return_to] if params[:return_to]
  end
 
  def create
    if !using_open_id?
      redirect_to new_session_path
      return
    end
    authenticate_with_open_id(params[:openid_url], {:optional => %w(fullname email nickname)}) do |result, identity_url|
      @openid_url = normalize_url(identity_url)
      if !(user_identity_url = IdentityUrl.find_by_url(@openid_url))
        @openid_url_not_found = true
        render :action => 'new'
      elsif !result.successful?
        @authentication_error = result.message
        render :action => 'new'
      else
        self.current_user = user_identity_url.user
        redirect_back_or_default(root_path)
        session[:return_to] = nil
      end
    end
  rescue OpenIdAuthentication::InvalidOpenId
    render :action => 'new'
  end
 
  def destroy
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(root_path)
  end
end
