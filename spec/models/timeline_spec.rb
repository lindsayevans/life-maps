require File.dirname(__FILE__) + '/../spec_helper'

describe Timeline, "validations" do
  fixtures :timelines

  before(:each) do
    @user = User.new
  end

  it "should ensure uniqueness of friendly_url" do
    existing_timeline = Timeline.create!(:name => 'Where I\'ve Lived', :user => @user, :friendly_url => 'test.life-maps.org')
    new_timeline = Timeline.new(:name => 'This is a dup', :user => @user, :friendly_url => 'test.life-maps.org')
    new_timeline.should have(1).error_on(:friendly_url)
  end

  it "should have a name" do
    new_timeline = Timeline.new(:user => @user, :friendly_url => 'test.life-maps.org')
    new_timeline.should have(1).error_on(:name)
  end

  it "should have a user" do
    new_timeline = Timeline.new(:name => 'This is a new timeline', :friendly_url => 'test.life-maps.org')
    new_timeline.should have(1).error_on(:user)
  end

  after(:each) do
  end

end
