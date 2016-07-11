require "time"

class BusinessHours
	@@DAYS = { :sun => 0 , :mon => 1 ,:tue => 2, :wed => 3, :thur => 4,:fri => 5,:sat => 6 }
	def initialize(open,close)
		@open = open
		@close = close
		@day_timings = Hash.new([@open,@close])
		@closed = [] 
	end

	def closed(*list)
		list.each do | item |
			if item.is_a? (Symbol)
				@closed << @@DAYS[item] 
			else
				item = Time.parse(item).strftime("%d-%m-%Y")
				@closed << item
			end
		end
	end

	def update(day,open,close)
                        if day.is_a? (Symbol)
                                @day_timings[@@DAYS[day]] = [open,close]
                        else
				day = Time.parse(day).strftime("%d-%m-%Y")
                                @day_timings[day] = [open,close]
                        end
        end
	def display_schedule
		@day_timings.each do | k , v |
			puts "#{k}: #{v}"
		end
		puts "Closed on:"
		@closed.each do | d |	
			puts d
		end
	end

	def calculate_deadline(job_length,job_start)
		job_day = Time.parse(job_start).strftime("%d-%m-%Y").to_s
		job_wday = Time.parse(job_start).strftime("%w").to_i
		job_start_time = Time.parse(job_start).strftime("%I:%M %p")
		if !@closed.include?(job_day) && !@closed.include?(job_wday)
			day_start = @day_timings.key?(job_day) ? @day_timings[job_day][0] : @day_timings[job_wday][0] 
			day_end = @day_timings.key?(job_day) ? @day_timings[job_day][1] : @day_timings[job_wday][1]
			if (Time.parse(job_start_time) - Time.parse(day_start)) < 0
				job_start_time = day_start
			end
	
			if job_start.include? ("00:00 AM")
				job_start.sub!("00:00 AM",job_start_time)
			end
			if (Time.parse(day_end) - Time.parse(job_start_time)) >= job_length 
				return "#{(Time.parse(job_start) + job_length).strftime("%a %b %d %H:%M:%S %Y")}"  
			else	
				portion_completed = Time.parse(day_end) - Time.parse(job_start_time)
				if portion_completed > 0
					job_length = job_length - portion_completed
				end
			end
		end
			next_day = (Time.parse(job_start) + 24*60*60).strftime("%B %d,%Y 00:00 AM")
			calculate_deadline(job_length,next_day)
		
	end
end

hours = BusinessHours.new("9:00 AM","3:00 PM")
hours.update(:fri,"10:00 AM","5:00 PM")
hours.update("Dec 24,2010","8:00 AM","1:00 PM")
hours.closed(:sun,:wed,"Dec 25,2010")

hours.display_schedule

puts "Testcase 1:"
puts hours.calculate_deadline(2*60*60,"Jun 7,2010 9:10 AM")
puts "Testcase 2:"
puts hours.calculate_deadline(15*60,"Jun 8,2010 2:48 PM")
puts "Testcase 3:"
puts hours.calculate_deadline(7*60*60,"Dec 23, 2010 2:45 PM")

