require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/identity_urls/new.html.erb" do
  include IdentityUrlsHelper
  
  before(:each) do
    assigns[:identity_url] = stub_model(IdentityUrl,
      :new_record? => true,
      :url => "value for url"
    )
  end

  it "should render new form" do
    render "/identity_urls/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", identity_urls_path) do
      with_tag("textarea#identity_url_url[name=?]", "identity_url[url]")
    end
  end
end


