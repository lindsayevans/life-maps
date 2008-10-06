require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/place_types/index.html.erb" do
  include PlaceTypesHelper
  
  before(:each) do
    assigns[:place_types] = [
      stub_model(PlaceType,
        :name => "value for name",
        :colour => "value for colour"
      ),
      stub_model(PlaceType,
        :name => "value for name",
        :colour => "value for colour"
      )
    ]
  end

  it "should render list of place_types" do
    render "/place_types/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for colour", 2)
  end
end

