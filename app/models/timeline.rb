class Timeline < ActiveRecord::Base

    belongs_to :user

    validates_uniqueness_of :friendly_url
    validates_presence_of :name
    validates_presence_of :user

end
