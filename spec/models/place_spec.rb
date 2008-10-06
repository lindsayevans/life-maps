require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Place do
  before(:each) do
    @valid_attributes = {
      :timeline_id => "1",
      :user_id => "1",
      :name => "value for name",
      :coordinates => ,
      :from_start => Date.today,
      :from_end => Date.today,
      :from_original => "value for from_original",
      :from_resolution => "value for from_resolution",
      :to_start => Date.today,
      :to_end => Date.today,
      :to_original => "value for to_original",
      :to_resolution => "value for to_resolution",
      :description => "value for description",
      :place_type_id => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Place.create!(@valid_attributes)
  end
end
