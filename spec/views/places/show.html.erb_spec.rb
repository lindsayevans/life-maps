require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/places/show.html.erb" do
  include PlacesHelper
  
  before(:each) do
    assigns[:place] = @place = stub_model(Place,
      :name => "value for name",
      :coordinates => ,
      :from_original => "value for from_original",
      :from_resolution => "value for from_resolution",
      :to_original => "value for to_original",
      :to_resolution => "value for to_resolution",
      :description => "value for description",
    )
  end

  it "should render attributes in <p>" do
    render "/places/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(//)
    response.should have_text(/value\ for\ from_original/)
    response.should have_text(/value\ for\ from_resolution/)
    response.should have_text(/value\ for\ to_original/)
    response.should have_text(/value\ for\ to_resolution/)
    response.should have_text(/value\ for\ description/)
  end
end

