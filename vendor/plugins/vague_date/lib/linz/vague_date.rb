require 'yaml'
require 'chronic'

module Linz

    def self.included(base) # :nodoc:
        base.extend ClassMethods
    end

    module ClassMethods
        @vague_attributes = []
        def vague_date attr
            # setter
            define_method((attr.to_s + '=').to_sym, Proc.new { |v| 
                vague_date = Linz::VagueDate.parse v.to_s
		self[(attr.to_s + '_start').to_sym] = vague_date.start
		self[(attr.to_s + '_end').to_sym] = vague_date.end
		self[(attr.to_s + '_resolution').to_sym] = vague_date.resolution
		self[(attr.to_s + '_original').to_sym] = vague_date.original
            })

            # getter
            define_method(attr) {
                return Linz::VagueDate.new(
		    self[(attr.to_s + '_start').to_sym],
		    self[(attr.to_s + '_end').to_sym],
		    self[(attr.to_s + '_resolution').to_sym],
		    self[(attr.to_s + '_original').to_sym]
		)
            }
        end

    end

    class VagueDate

        attr_accessor :start, :end, :resolution, :original
        
        def initialize startdate = DateTime.now, enddate = DateTime.now, resolution = :day, original = 'now'
            @start = startdate
            @end = enddate
            @resolution = resolution.to_s
            @original = original
        end
        def to_s
            "<Linz:VagueDate resolution=\"#{self.resolution.to_s}\" original=\"#{self.original}\" start=\"#{self.start.strftime("%d/%m/%Y")}\" end=\"#{self.end.strftime("%d/%m/%Y")}\" />"
        end

	def days
	    seconds = self.end.to_i - self.start.to_i
	    days = seconds / 60 / 60 / 24
	    return days
	end

        def VagueDate.parse original

            start_date = nil
            end_date = nil
            parts = original.split /[\/\-\s]+/
            is_decade = false
            is_year = false
	    is_month = false
	    is_season = false
            resolution = :day

	    # dummy data
	    seasons = {
		:summer => {:start => '1/1/', :end => '3/31'},
		:spring => {:start => '4/1/', :end => '6/30'},
		:winter => {:start => '7/1/', :end => '9/31'},
		:autumn => {:start => '10/1/', :end => '12/31'},
		:fall => {:start => '10/1/', :end => '12/31'}
	    }
	    decade_names = {
		:naughties => 0,
		:zeroes => 0,
		:tens => 1,
		:twenties => 2,
		:thirties => 3,
		:forties => 4,
		:fifties => 5,
		:sixties => 6,
		:seventies => 7,
		:eighties => 8,
		:nineties => 9
	    }

	    if parts.length == 1 then # year/decade
                decade_match = original.match /([0-9]{2,4})[^\s]*s/i
                decade_in_words_match = original.match /([a-z]+es)/i
                if !decade_match.nil? then #decade
		    decade = decade_match[1]
                    is_decade = true
                    resolution = :decade
                    start_date = Chronic.parse '1/1/' + decade
                    end_date = (Chronic.parse('1/1/'+(start_date.year+10).to_s).to_date-1).to_time
                elsif !decade_in_words_match.nil? then #decade in words
		    decade = decade_names[decade_in_words_match[1].downcase.to_sym] * 10
                    is_decade = true
                    resolution = :decade
                    start_date = Chronic.parse '1/1/' + decade.to_s
                    end_date = (Chronic.parse('1/1/'+(start_date.year+10).to_s).to_date-1).to_time
                else # year
                    is_year = true
                    resolution = :year
                    start_date = Chronic.parse '1/1/' + parts[0]
                    end_date = Chronic.parse '31/12/' + parts[0]
                end
            elsif parts.length == 2 then # month/season + year
		season_match = parts[0].match /(summer|spring|winter|autumn|fall)/i
                word_month_match = parts[0].match /([a-z]*)/i # word month
                month_match = parts[0].match /([0-9]*)/i # numeric month
		year_match = original.match /([0-9]{2,4})/i

                if !season_match.nil? then
                    is_season = true
                    resolution = :season
                    start_date = Chronic.parse seasons[season_match[1].downcase.to_sym][:start] + year_match[1]
                    end_date = Chronic.parse seasons[season_match[1].downcase.to_sym][:end] + year_match[1]
                elsif !word_month_match.nil? then
                    is_month = true
                    resolution = :month
                    start_date = Chronic.parse '1 ' + word_month_match[1] + ' ' + year_match[1]
                    end_date = start_date.end_of_month # TODO: fix so doesn't rely on ActiveSupport::CoreExtensions::Time::Calculations
                elsif !month_match.nil? then
                    is_month = true
                    resolution = :month
                    start_date = Chronic.parse '1/' + month_match[1] + '/' + year_match[1]
                    end_date = start_date.end_of_month # TODO: fix so doesn't rely on ActiveSupport::CoreExtensions::Time::Calculations
                end
            else # other
                start_date = Chronic.parse original
                end_date = Chronic.parse original
            end
            #end_date = start_date
            #puts start_date.strftime('%d/%m/%Y') + ', ' + end_date.strftime('%d/%m/%Y')
            raise StandardError, "Invalid date format" if start_date.nil? || end_date.nil?
            return Linz::VagueDate.new(start_date, end_date, resolution, original)
        end

    end

end
