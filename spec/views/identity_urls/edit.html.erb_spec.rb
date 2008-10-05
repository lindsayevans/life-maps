require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/identity_urls/edit.html.erb" do
  include IdentityUrlsHelper
  
  before(:each) do
    assigns[:identity_url] = @identity_url = stub_model(IdentityUrl,
      :new_record? => false,
      :url => "value for url"
    )
  end

  it "should render edit form" do
    render "/identity_urls/edit.html.erb"
    
    response.should have_tag("form[action=#{identity_url_path(@identity_url)}][method=post]") do
      with_tag('textarea#identity_url_url[name=?]', "identity_url[url]")
    end
  end
end


