require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PlaceTypesController do

  def mock_place_type(stubs={})
    @mock_place_type ||= mock_model(PlaceType, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all place_types as @place_types" do
      PlaceType.should_receive(:find).with(:all).and_return([mock_place_type])
      get :index
      assigns[:place_types].should == [mock_place_type]
    end

    describe "with mime type of xml" do
  
      it "should render all place_types as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PlaceType.should_receive(:find).with(:all).and_return(place_types = mock("Array of PlaceTypes"))
        place_types.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested place_type as @place_type" do
      PlaceType.should_receive(:find).with("37").and_return(mock_place_type)
      get :show, :id => "37"
      assigns[:place_type].should equal(mock_place_type)
    end
    
    describe "with mime type of xml" do

      it "should render the requested place_type as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PlaceType.should_receive(:find).with("37").and_return(mock_place_type)
        mock_place_type.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new place_type as @place_type" do
      PlaceType.should_receive(:new).and_return(mock_place_type)
      get :new
      assigns[:place_type].should equal(mock_place_type)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested place_type as @place_type" do
      PlaceType.should_receive(:find).with("37").and_return(mock_place_type)
      get :edit, :id => "37"
      assigns[:place_type].should equal(mock_place_type)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created place_type as @place_type" do
        PlaceType.should_receive(:new).with({'these' => 'params'}).and_return(mock_place_type(:save => true))
        post :create, :place_type => {:these => 'params'}
        assigns(:place_type).should equal(mock_place_type)
      end

      it "should redirect to the created place_type" do
        PlaceType.stub!(:new).and_return(mock_place_type(:save => true))
        post :create, :place_type => {}
        response.should redirect_to(place_type_url(mock_place_type))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved place_type as @place_type" do
        PlaceType.stub!(:new).with({'these' => 'params'}).and_return(mock_place_type(:save => false))
        post :create, :place_type => {:these => 'params'}
        assigns(:place_type).should equal(mock_place_type)
      end

      it "should re-render the 'new' template" do
        PlaceType.stub!(:new).and_return(mock_place_type(:save => false))
        post :create, :place_type => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested place_type" do
        PlaceType.should_receive(:find).with("37").and_return(mock_place_type)
        mock_place_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :place_type => {:these => 'params'}
      end

      it "should expose the requested place_type as @place_type" do
        PlaceType.stub!(:find).and_return(mock_place_type(:update_attributes => true))
        put :update, :id => "1"
        assigns(:place_type).should equal(mock_place_type)
      end

      it "should redirect to the place_type" do
        PlaceType.stub!(:find).and_return(mock_place_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(place_type_url(mock_place_type))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested place_type" do
        PlaceType.should_receive(:find).with("37").and_return(mock_place_type)
        mock_place_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :place_type => {:these => 'params'}
      end

      it "should expose the place_type as @place_type" do
        PlaceType.stub!(:find).and_return(mock_place_type(:update_attributes => false))
        put :update, :id => "1"
        assigns(:place_type).should equal(mock_place_type)
      end

      it "should re-render the 'edit' template" do
        PlaceType.stub!(:find).and_return(mock_place_type(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested place_type" do
      PlaceType.should_receive(:find).with("37").and_return(mock_place_type)
      mock_place_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the place_types list" do
      PlaceType.stub!(:find).and_return(mock_place_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(place_types_url)
    end

  end

end
