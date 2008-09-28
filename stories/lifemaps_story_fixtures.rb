module LifemapsStoryFixtures
  def timeline(user)
    Timeline.create!(:name => 'Where I\'ve Lived', :user => user, :friendly_url => 'story-test.life-maps.org')
  end

  def other_user
    User.create!(:id => 1)
  end

  def me
    User.create!(:id => 2)
  end
end
