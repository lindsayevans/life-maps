# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'ff04819119089bcf242e03ba848342a48ac7977f83a1a846d4fa42c0fadad64363c46d48316c8148263bd43a50606a08d42ba673a2212df6d61a8a9b060d198e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  def d(*o)
    render :text => '<pre>'+YAML::dump(o)+'</pre>'
  end

end
