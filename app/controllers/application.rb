# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  class NotFound < StandardError; end

  include AuthenticatedSystem
  before_filter :login_from_cookie


  before_filter :get_place_types
  def get_place_types
    @place_types = PlaceType.find :all
  end

 
  helper :all
  
  rescue_from ActiveRecord::RecordNotFound, NotFound do
    render :file => File.join(RAILS_ROOT, "public", "404.html"), :status => :not_found
  end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'ff04819119089bcf242e03ba848342a48ac7977f83a1a846d4fa42c0fadad64363c46d48316c8148263bd43a50606a08d42ba673a2212df6d61a8a9b060d198e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  def insertions
    render :template => 'application/insertions.js.rjs'
  end


  protected
    before_filter :remove_trailing_slashes
    def remove_trailing_slashes
      if (uri = request.request_uri).length > 1 and uri[-1,1] == '/'
        redirect_to uri.chop, :status => 301
        return false
      end
    end
    
    before_filter :no_www
    def no_www
     if (bad_subdirs = ["ww", "www"]).any? {|s| [s]==request.subdomains(2)}
        redirect_to :host => request.domain(TLD_LENGTH), :status => 301
       return false
     end
    end

    def check_is_admin
      if !current_user || !current_user.is_admin?
	flash[:warning] = 'Sorry, you don\'t have permission to view that page'
	redirect_to '/login'
	return false
      end
    end
    
    def render_404
      render :file => "#{RAILS_ROOT}/public/404.html", :status => :not_found
    end
  
  def d(*o)
    render :text => '<pre>'+YAML::dump(o)+'</pre>'
  end

end
