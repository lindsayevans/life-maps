class Place < ActiveRecord::Base

  belongs_to :timeline
  belongs_to :user
  has_one :place_type

  validates_presence_of :latitude, :longitude
  validates_presence_of :name

  vague_date :from
  vague_date :to

  def latitude
    coordinates.lat unless coordinates.nil?
  end

  def latitude=(lat)
    @lat = lat
    self.coordinates = Point.from_lon_lat(@lon,@lat) unless @lon.nil?
  end

  def longitude
    coordinates.lat unless coordinates.nil?
  end

  def longitude=(lon)
    @lon = lon
    self.coordinates = Point.from_on_lat(@lon,@lat) unless @lat.nil?
  end

  def length divisor = 1
    seconds = self.to.start.to_time.to_i - self.from.start.to_time.to_i
    days = seconds / 60 / 60 / 24
    return days / divisor
  end

  def find_close_places_by_line_length(distance=1, limit=5)
    Place.find :all, :conditions => ["id != ? AND GLength(GeomFromText(CONCAT('LineString(? ?,',  X(coordinates), ' ', Y(coordinates),')'))) < ?", self[:id], self.latitude, self.longitude, distance], :limit => limit
  end

  # Find places within a certain distance
  def find_close_places(distance=1000, limit=5)
    lat = self.latitude
    lon = self.longitude
    radius = 6370997.0
    sql = "SELECT *
FROM places
WHERE id != #{self[:id]}
  AND #{radius} * (2 * ATAN2(SQRT(POW(SIN(((#{lat} - X(coordinates)) * 0.0174532925199433)/2),2) + COS(X(coordinates) * 0.0174532925199433) * COS(#{lat} * 0.0174532925199433) * POW(SIN(((#{lon} - Y(coordinates)) * 0.0174532925199433)/2),2)), SQRT(1-(POW(SIN(((#{lat} - X(coordinates)) * 0.0174532925199433)/2),2) + COS(X(coordinates) * 0.0174532925199433) * COS(#{lat} * 0.0174532925199433) * POW(SIN(((#{lon} - Y(coordinates)) * 0.0174532925199433)/2),2))))) <= #{distance}
LIMIT #{limit}"
#puts sql
    Place.find_by_sql sql
  end

  # get the distance in metres between this place & another
  def distance place
    self.coordinates.spherical_distance(place.coordinates)
  end


end
