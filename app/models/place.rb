class Place < ActiveRecord::Base

  belongs_to :timeline
  belongs_to :user
  has_one :place_type

  validates_presence_of :latitude, :longitude
  validates_presence_of :name

  vague_date :from
  vague_date :to

  def latitude
    coordinates.x unless coordinates.nil?
  end

  def latitude=(lat)
    @lat = lat
    self.coordinates = Point.from_x_y(@lat,@lon) unless @lon.nil?
  end

  def longitude
    coordinates.y unless coordinates.nil?
  end

  def longitude=(lon)
    @lon = lon
    self.coordinates = Point.from_x_y(@lat,@lon) unless @lat.nil?
  end

  def length divisor = 1
    seconds = self.to.start.to_time.to_i - self.from.start.to_time.to_i
    days = seconds / 60 / 60 / 24
    return days / divisor
  end


end
