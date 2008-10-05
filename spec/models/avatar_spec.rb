require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Avatar do
  before(:each) do
    @valid_attributes = {
      :temp_user_id => "1",
      :user_id => "1",
      :parent_id => "1",
      :content_type => "value for content_type",
      :filename => "value for filename",
      :thumbnail => "value for thumbnail",
      :size => "1",
      :width => "1",
      :height => "1",
      :created_at => Time.now,
      :updated_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Avatar.create!(@valid_attributes)
  end
end
