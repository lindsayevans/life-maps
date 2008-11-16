class PagesController < ApplicationController

    def home
	@latest_timelines = Timeline.find :all, :order => 'created_at DESC', :limit => 5
    end

end
