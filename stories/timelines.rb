require File.join(File.dirname(__FILE__), "helper")
 
with_steps_for :timelines do
  run File.expand_path(__FILE__).gsub("rb", "story"), :type => RailsStory
end
