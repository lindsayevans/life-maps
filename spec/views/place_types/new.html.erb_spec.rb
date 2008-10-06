require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/place_types/new.html.erb" do
  include PlaceTypesHelper
  
  before(:each) do
    assigns[:place_type] = stub_model(PlaceType,
      :new_record? => true,
      :name => "value for name",
      :colour => "value for colour"
    )
  end

  it "should render new form" do
    render "/place_types/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", place_types_path) do
      with_tag("input#place_type_name[name=?]", "place_type[name]")
      with_tag("input#place_type_colour[name=?]", "place_type[colour]")
    end
  end
end


