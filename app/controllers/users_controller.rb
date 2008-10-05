class UsersController < ApplicationController
  before_filter :login_required, :only => %w(edit update update_privacy update_profile_details)
 
  def show
    @user = User.find_by_nick_name(params[:id])
    raise NotFound unless @user
  end
  
  def index
    @users = User.paginate(:page => params[:page], :order => "nick_name ASC", :per_page => 48)
  end
  
  def new
    @identity_url = IdentityUrl.new(:url => params[:openid_url])
  end
  
  def verify
    if !using_open_id?
      redirect_to new_user_path
      return
    end
    authenticate_with_open_id(params[:openid_url], {:optional => %w(fullname email nickname)}) do |result, identity_url, sreg_fields|
      @identity_url = IdentityUrl.new(:url => identity_url)
      if !@identity_url.valid?
        render :action => 'new'
      elsif !result.successful?
        @verification_error = result.message
        render :action => 'new'
      else
        session[:verified_openid_details] = {:identity_url => identity_url, :sreg_fields => sreg_fields}
        redirect_to details_users_path
      end
    end
  rescue OpenIdAuthentication::InvalidOpenId
    render :action => 'new'
  end
  
  def details
    unless session[:verified_openid_details]
      redirect_to new_user_path
      return
    end
    
    @user = User.new(:openid_sreg_fields => session[:verified_openid_details][:sreg_fields])
    @identity_url = @user.identity_urls.build(:url => session[:verified_openid_details][:identity_url])
  end
  
  def create
    unless session[:verified_openid_details]
      redirect_to new_user_path
      return
    end
 
    @user = User.new(params[:user])
    @identity_url = @user.identity_urls.build(:url => session[:verified_openid_details][:identity_url])
    @user.save!
    session[:verified_openid_details] = nil
    self.current_user = @user
    if session[:return_to_path]
      redirect_to session[:return_to_path]
      session[:return_to_path] = nil
    else
      redirect_to user_path(@user)
    end
  rescue ActiveRecord::RecordInvalid
    render :action => 'details'
  end
 
  def edit
    render_404 && return if params[:id]
    @user = current_user
    @avatar = @user.avatar|| Avatar.new
    @identity_urls = @user.identity_urls
  end
 
  def update
    render_404 && return if params[:id]
    @user = current_user
    @user.attributes = params[:user]
    @user.save!
    flash[:notice] = "Looksies... your user profile has been updated"
    redirect_to user_path(@user)
  rescue ActiveRecord::RecordInvalid
    render :action => 'edit'
  end
  
  def update_profile_details
    @user = current_user
    @user.update_attributes(params[:user])
    @user.save!
    redirect_back_or_default user_path(@user)
  end
end
