steps_for :timelines do
  Given "the timeline exists" do
    @timeline = timeline(me)
  end

  Given "the timeline isn't public" do
    @timeline.public = false
  end

  Given "I didn't create the timeline" do
    @timeline.user = other_user
  end

  Given "I created the timeline" do
    @timeline.user = me
  end

  Given "I am logged in" do
    login(me)
  end

  Given "I am not logged in" do
  end

  When "I view the timelines page" do
    get timelines_path
  end

  When "I view the timeline page" do
    get timeline_path(@timeline), nil, :user_agent => iphone_user_agent
  end
  
  Then "I see the page" do
    response.should be_success
  end
  
  Then "I can edit the timeline" do
    response.should be_success
    response.should include_text('Edit timeline')
  end

  Then "I see an unauthorised error" do
    response.should be_error
  end

end
