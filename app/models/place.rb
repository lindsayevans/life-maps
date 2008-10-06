class Place < ActiveRecord::Base
  belongs_to :timeline
  belongs_to :user
  has_one :place_type

  attr_accessor :from, :to

  def latitude
    coordinates.x
  end

  def latitude=(lat)
    @lat = lat
    self.coordinates = Point.from_x_y(@lat,@lon) unless @lon.nil?
  end

  def longitude
    coordinates.y
  end

  def longitude=(lon)
    @lon = lon
    self.coordinates = Point.from_x_y(@lat,@lon) unless @lat.nil?

  end

end
