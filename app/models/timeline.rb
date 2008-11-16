class Timeline < ActiveRecord::Base

  belongs_to :user
  has_many :places, :dependent => :destroy, :order => 'places.from_start ASC, places.from_end ASC'
  has_many :place_types, :through => :places

  #validates_uniqueness_of :friendly_url # if not empty
  validates_presence_of :name
  validates_presence_of :user
  validates_associated :places

  after_update :save_places

  def can_be_edited_by(user)
    user.nil? ? false : user.can_edit?(self)
  end

  def can_be_viewed_by(user)
    user.nil? ? false : user.can_view?(self)
  end

  def existing_place_attributes=(place_attributes)
    places.reject(&:new_record?).each do |place|
      attributes = place_attributes[place.id.to_s]
      if attributes
        place.attributes = attributes
        place.from = attributes[:from_original]
        place.to = attributes[:to_original]
      else
        places.delete(place)
      end
    end
  end

  def new_place_attributes=(place_attributes)
    place_attributes.each do |attributes|
      attributes[:from] = attributes[:from_original]
      attributes[:to] = attributes[:to_original]
      places.build(attributes)
    end
  end

  def save_places
    places.each do |place|
      place.save(false)
    end
  end

end
