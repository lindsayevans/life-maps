class User < ActiveRecord::Base

    has_many :timelines

    def can_edit? timeline
	self == timeline.user
    end

    def can_view? timeline
	timeline.public || can_edit? timeline
    end

end
