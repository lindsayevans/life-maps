require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/place_types/edit.html.erb" do
  include PlaceTypesHelper
  
  before(:each) do
    assigns[:place_type] = @place_type = stub_model(PlaceType,
      :new_record? => false,
      :name => "value for name",
      :colour => "value for colour"
    )
  end

  it "should render edit form" do
    render "/place_types/edit.html.erb"
    
    response.should have_tag("form[action=#{place_type_path(@place_type)}][method=post]") do
      with_tag('input#place_type_name[name=?]', "place_type[name]")
      with_tag('input#place_type_colour[name=?]', "place_type[colour]")
    end
  end
end


