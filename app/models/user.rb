require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login, :if => :not_openid?
  validates_length_of       :login,    :within => 3..40, :if => :not_openid?
  validates_uniqueness_of   :login, :if => :not_openid?
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message, :if => :not_openid?

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true, :if => :not_openid?
  validates_length_of       :name,     :maximum => 100, :if => :not_openid?

  validates_presence_of     :email, :if => :not_openid?
  validates_length_of       :email,    :within => 6..100, :if => :not_openid? #r@a.wk
  validates_uniqueness_of   :email, :if => :not_openid?
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message, :if => :not_openid?

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url



    # Timelines stuff
    has_many :timelines

    def can_edit?(timeline)
	self == timeline.user
    end

    def can_view?(timeline)
	timeline.public || can_edit?(timeline)
    end


  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end

  def not_openid?
    identity_url.blank?
  end


end
