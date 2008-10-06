require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/places/edit.html.erb" do
  include PlacesHelper
  
  before(:each) do
    assigns[:place] = @place = stub_model(Place,
      :new_record? => false,
      :name => "value for name",
      :coordinates => ,
      :from_original => "value for from_original",
      :from_resolution => "value for from_resolution",
      :to_original => "value for to_original",
      :to_resolution => "value for to_resolution",
      :description => "value for description",
    )
  end

  it "should render edit form" do
    render "/places/edit.html.erb"
    
    response.should have_tag("form[action=#{place_path(@place)}][method=post]") do
      with_tag('input#place_name[name=?]', "place[name]")
      with_tag('input#place_coordinates[name=?]', "place[coordinates]")
      with_tag('input#place_from_original[name=?]', "place[from_original]")
      with_tag('input#place_from_resolution[name=?]', "place[from_resolution]")
      with_tag('input#place_to_original[name=?]', "place[to_original]")
      with_tag('input#place_to_resolution[name=?]', "place[to_resolution]")
      with_tag('textarea#place_description[name=?]', "place[description]")
    end
  end
end


