
class Playlist
	def initialize(arr,i)
		@arr = arr
		@shift = i
	end
	def skip_tracks
		len = @arr.length
		@shift = @shift >=0 ? @shift : @shift % len
		for itr in 0...@shift
		     temp = @arr.shift
		     @arr << temp
		end
	end

	def display_list
		@arr.each do | pl |
			puts pl
		end
	end
end


playlist1 = Playlist.new([2,3,4,5,6,7,8,9,12,13],-3)
playlist1.display_list
playlist1.skip_tracks
puts "After Skipping"
playlist1.display_list


playlist2 = Playlist.new([34,25,24,65,84,90,12,43,56,67,32,17],4)
playlist2.display_list
playlist2.skip_tracks
puts "After skipping"
playlist2.display_list
