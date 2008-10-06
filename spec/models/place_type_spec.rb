require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PlaceType do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :colour => "value for colour"
    }
  end

  it "should create a new instance given valid attributes" do
    PlaceType.create!(@valid_attributes)
  end
end
