require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/places/index.html.erb" do
  include PlacesHelper
  
  before(:each) do
    assigns[:places] = [
      stub_model(Place,
        :name => "value for name",
        :coordinates => ,
        :from_original => "value for from_original",
        :from_resolution => "value for from_resolution",
        :to_original => "value for to_original",
        :to_resolution => "value for to_resolution",
        :description => "value for description",
      ),
      stub_model(Place,
        :name => "value for name",
        :coordinates => ,
        :from_original => "value for from_original",
        :from_resolution => "value for from_resolution",
        :to_original => "value for to_original",
        :to_resolution => "value for to_resolution",
        :description => "value for description",
      )
    ]
  end

  it "should render list of places" do
    render "/places/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", , 2)
    response.should have_tag("tr>td", "value for from_original", 2)
    response.should have_tag("tr>td", "value for from_resolution", 2)
    response.should have_tag("tr>td", "value for to_original", 2)
    response.should have_tag("tr>td", "value for to_resolution", 2)
    response.should have_tag("tr>td", "value for description", 2)
  end
end

