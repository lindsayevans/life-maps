require 'yaml'
require 'chronic'

module Linz

    def self.included(base) # :nodoc:
        base.extend ClassMethods
    end

    module ClassMethods
        @vague_attributes = []
        def vague_datetime attr
            # setter
            define_method((attr.to_s + '=').to_sym, Proc.new { |v| 
                puts "setting #{attr.to_s} to #{v.to_s}"
                vague_datetime = Linz::VagueDatetime.parse v.to_s
                #puts vague_datetime
                self.attributes[(attr.to_s + '_start')] = vague_datetime.start
                self.attributes[(attr.to_s + '_end')] = vague_datetime.end
                self.attributes[(attr.to_s + '_original')] = vague_datetime.original
            })

            # getter
            define_method(attr) {
                puts attr.to_s + '_start: '+ self.attributes[(attr.to_s + '_start')].to_s
                puts attr.to_s + '_end: '+ self.attributes[(attr.to_s + '_end')].to_s
                puts attr.to_s + '_original: '+ self.attributes[(attr.to_s + '_original')].to_s
                return Linz::VagueDatetime.new self.attributes[(attr.to_s + '_start')], self.attributes[(attr.to_s + '_end')], self.attributes[(attr.to_s + '_original')]
            }
        end

    end

    class VagueDatetime

        attr_accessor :start, :end, :resolution, :original
        
        def initialize startdate = DateTime.now, enddate = DateTime.now, resolution = :day, original = 'now'
            @start = startdate
            @end = enddate
            @resolution = resolution
            @original = original
        end

        def VagueDatetime.parse original

            parts = original.split /\/- /i
            is_decade = false
            is_year = false
            resolution = :day
puts YAML::dump parts
            if parts.length == 1 then # year/decade
                decade_match = original.match /([0-9]*)s/i
                if !decade_match.nil? then
                    is_decade = true
                    resolution = :decade
                    base_date = Chronic.parse decade_match[1]
                else
                    is_year = true
                    resolution = :year
                    base_date = Chronic.parse original
                end
            else # other
                base_date = Chronic.parse original
            end
            puts base_date.strftime '%d/%m/%Y'
            return Linz::VagueDatetime.new DateTime.now, DateTime.now, resolution, original
        end

    end

end
