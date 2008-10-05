require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IdentityUrlsController do

  def mock_identity_url(stubs={})
    @mock_identity_url ||= mock_model(IdentityUrl, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all identity_urls as @identity_urls" do
      IdentityUrl.should_receive(:find).with(:all).and_return([mock_identity_url])
      get :index
      assigns[:identity_urls].should == [mock_identity_url]
    end

    describe "with mime type of xml" do
  
      it "should render all identity_urls as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        IdentityUrl.should_receive(:find).with(:all).and_return(identity_urls = mock("Array of IdentityUrls"))
        identity_urls.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested identity_url as @identity_url" do
      IdentityUrl.should_receive(:find).with("37").and_return(mock_identity_url)
      get :show, :id => "37"
      assigns[:identity_url].should equal(mock_identity_url)
    end
    
    describe "with mime type of xml" do

      it "should render the requested identity_url as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        IdentityUrl.should_receive(:find).with("37").and_return(mock_identity_url)
        mock_identity_url.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new identity_url as @identity_url" do
      IdentityUrl.should_receive(:new).and_return(mock_identity_url)
      get :new
      assigns[:identity_url].should equal(mock_identity_url)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested identity_url as @identity_url" do
      IdentityUrl.should_receive(:find).with("37").and_return(mock_identity_url)
      get :edit, :id => "37"
      assigns[:identity_url].should equal(mock_identity_url)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created identity_url as @identity_url" do
        IdentityUrl.should_receive(:new).with({'these' => 'params'}).and_return(mock_identity_url(:save => true))
        post :create, :identity_url => {:these => 'params'}
        assigns(:identity_url).should equal(mock_identity_url)
      end

      it "should redirect to the created identity_url" do
        IdentityUrl.stub!(:new).and_return(mock_identity_url(:save => true))
        post :create, :identity_url => {}
        response.should redirect_to(identity_url_url(mock_identity_url))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved identity_url as @identity_url" do
        IdentityUrl.stub!(:new).with({'these' => 'params'}).and_return(mock_identity_url(:save => false))
        post :create, :identity_url => {:these => 'params'}
        assigns(:identity_url).should equal(mock_identity_url)
      end

      it "should re-render the 'new' template" do
        IdentityUrl.stub!(:new).and_return(mock_identity_url(:save => false))
        post :create, :identity_url => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested identity_url" do
        IdentityUrl.should_receive(:find).with("37").and_return(mock_identity_url)
        mock_identity_url.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :identity_url => {:these => 'params'}
      end

      it "should expose the requested identity_url as @identity_url" do
        IdentityUrl.stub!(:find).and_return(mock_identity_url(:update_attributes => true))
        put :update, :id => "1"
        assigns(:identity_url).should equal(mock_identity_url)
      end

      it "should redirect to the identity_url" do
        IdentityUrl.stub!(:find).and_return(mock_identity_url(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(identity_url_url(mock_identity_url))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested identity_url" do
        IdentityUrl.should_receive(:find).with("37").and_return(mock_identity_url)
        mock_identity_url.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :identity_url => {:these => 'params'}
      end

      it "should expose the identity_url as @identity_url" do
        IdentityUrl.stub!(:find).and_return(mock_identity_url(:update_attributes => false))
        put :update, :id => "1"
        assigns(:identity_url).should equal(mock_identity_url)
      end

      it "should re-render the 'edit' template" do
        IdentityUrl.stub!(:find).and_return(mock_identity_url(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested identity_url" do
      IdentityUrl.should_receive(:find).with("37").and_return(mock_identity_url)
      mock_identity_url.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the identity_urls list" do
      IdentityUrl.stub!(:find).and_return(mock_identity_url(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(identity_urls_url)
    end

  end

end
