require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IdentityUrlsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "identity_urls", :action => "index").should == "/identity_urls"
    end
  
    it "should map #new" do
      route_for(:controller => "identity_urls", :action => "new").should == "/identity_urls/new"
    end
  
    it "should map #show" do
      route_for(:controller => "identity_urls", :action => "show", :id => 1).should == "/identity_urls/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "identity_urls", :action => "edit", :id => 1).should == "/identity_urls/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "identity_urls", :action => "update", :id => 1).should == "/identity_urls/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "identity_urls", :action => "destroy", :id => 1).should == "/identity_urls/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/identity_urls").should == {:controller => "identity_urls", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/identity_urls/new").should == {:controller => "identity_urls", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/identity_urls").should == {:controller => "identity_urls", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/identity_urls/1").should == {:controller => "identity_urls", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/identity_urls/1/edit").should == {:controller => "identity_urls", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/identity_urls/1").should == {:controller => "identity_urls", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/identity_urls/1").should == {:controller => "identity_urls", :action => "destroy", :id => "1"}
    end
  end
end
