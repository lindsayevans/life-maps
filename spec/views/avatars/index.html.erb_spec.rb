require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/avatars/index.html.erb" do
  include AvatarsHelper
  
  before(:each) do
    assigns[:avatars] = [
      stub_model(Avatar,
        :content_type => "value for content_type",
        :filename => "value for filename",
        :thumbnail => "value for thumbnail",
        :size => "1",
        :width => "1",
        :height => "1",
      ),
      stub_model(Avatar,
        :content_type => "value for content_type",
        :filename => "value for filename",
        :thumbnail => "value for thumbnail",
        :size => "1",
        :width => "1",
        :height => "1",
      )
    ]
  end

  it "should render list of avatars" do
    render "/avatars/index.html.erb"
    response.should have_tag("tr>td", "value for content_type", 2)
    response.should have_tag("tr>td", "value for filename", 2)
    response.should have_tag("tr>td", "value for thumbnail", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

