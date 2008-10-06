class Timeline < ActiveRecord::Base

  belongs_to :user
  has_many :places, :order => 'places.from_start ASC, places.from_end ASC'
  has_many :place_types, :through => :places

  validates_uniqueness_of :friendly_url
  validates_presence_of :name
  validates_presence_of :user


  def can_be_edited_by(user)
    user.nil? ? false : user.can_edit?(self)
  end

  def can_be_viewed_by(user)
    user.nil? ? false : user.can_view?(self)
  end

end
