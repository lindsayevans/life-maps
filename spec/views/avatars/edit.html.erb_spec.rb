require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/avatars/edit.html.erb" do
  include AvatarsHelper
  
  before(:each) do
    assigns[:avatar] = @avatar = stub_model(Avatar,
      :new_record? => false,
      :content_type => "value for content_type",
      :filename => "value for filename",
      :thumbnail => "value for thumbnail",
      :size => "1",
      :width => "1",
      :height => "1",
    )
  end

  it "should render edit form" do
    render "/avatars/edit.html.erb"
    
    response.should have_tag("form[action=#{avatar_path(@avatar)}][method=post]") do
      with_tag('input#avatar_content_type[name=?]', "avatar[content_type]")
      with_tag('input#avatar_filename[name=?]', "avatar[filename]")
      with_tag('input#avatar_thumbnail[name=?]', "avatar[thumbnail]")
      with_tag('input#avatar_size[name=?]', "avatar[size]")
      with_tag('input#avatar_width[name=?]', "avatar[width]")
      with_tag('input#avatar_height[name=?]', "avatar[height]")
    end
  end
end


