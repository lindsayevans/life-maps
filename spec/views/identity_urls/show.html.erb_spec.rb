require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/identity_urls/show.html.erb" do
  include IdentityUrlsHelper
  
  before(:each) do
    assigns[:identity_url] = @identity_url = stub_model(IdentityUrl,
      :url => "value for url"
    )
  end

  it "should render attributes in <p>" do
    render "/identity_urls/show.html.erb"
    response.should have_text(/value\ for\ url/)
  end
end

