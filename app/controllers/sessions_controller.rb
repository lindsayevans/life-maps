# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  # render new.rhtml
  def new
  end


  def create

    logout_keeping_session!

    if using_open_id?
      open_id_authentication
    elsif params[:login]
      password_authentication(params[:login], params[:password])
    end
  end

  def create_old
    logout_keeping_session!

    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected

    def password_authentication(login, password)
      if self.current_user = User.authenticate(params[:login], params[:password])
        successful_login
      else
        failed_login("Invalid login or password")
      end
    end
 
    def open_id_authentication
      authenticate_with_open_id do |result, identity_url|
        if result.successful?
          if self.current_user = User.find_or_create_by_identity_url(identity_url)
            successful_login
          else
            failed_login "Sorry, no user by that identity URL exists (#{identity_url})"
          end
        else
          failed_login result.message
        end
      end
    end


  private
 
    def successful_login
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default(index_url)
      flash[:notice] = "Logged in successfully"
    end

    def failed_login(message)
      redirect_to(:action => 'login')
      #flash[:error] = "Couldn't log you in as '#{params[:login]}'"
      #logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
      flash[:warning] = message
    end


end
