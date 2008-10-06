require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/place_types/show.html.erb" do
  include PlaceTypesHelper
  
  before(:each) do
    assigns[:place_type] = @place_type = stub_model(PlaceType,
      :name => "value for name",
      :colour => "value for colour"
    )
  end

  it "should render attributes in <p>" do
    render "/place_types/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ colour/)
  end
end

