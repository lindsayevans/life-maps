require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/identity_urls/index.html.erb" do
  include IdentityUrlsHelper
  
  before(:each) do
    assigns[:identity_urls] = [
      stub_model(IdentityUrl,
        :url => "value for url"
      ),
      stub_model(IdentityUrl,
        :url => "value for url"
      )
    ]
  end

  it "should render list of identity_urls" do
    render "/identity_urls/index.html.erb"
    response.should have_tag("tr>td", "value for url", 2)
  end
end

