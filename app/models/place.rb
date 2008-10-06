class Place < ActiveRecord::Base
  belongs_to :timeline
  belongs_to :user
  has_one :place_type

  attr_accessor :from, :to

  def latitude
  end

  def latitude=(lat)
  end

  def longitude
  end

  def longitude=(lon)
  end

end
