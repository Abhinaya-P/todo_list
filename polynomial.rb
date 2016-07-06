
class Polynomial
  def initialize(numbers)
	@coefficients = numbers
  end
  def print_poly
    raise ArgumentError, 'Need atleast 2 coefficients' if !( @coefficients.length >= 2 )
    poly = ""
    power = @coefficients.length - 1
    @coefficients.each do | co |    
	if co != 0		
		if co > 0 && !poly.empty?    #setting the sign
		   poly << "+"
		end
		
		if power > 1               #constructing the polynomial
		   poly << ( co != 1 ? "#{co}x^#{power}" : "x^#{power}" ) 
		elsif power == 1
		   poly << ( co != 1 ? "#{co}x" : "x" )	
		else
	    	   poly << "#{co}"		
		end
	end
	power = power - 1
    end 
    return poly
 end
end

puts Polynomial.new([-3,-4,1,0,6]).print_poly
puts Polynomial.new([1,0,2]).print_poly
puts Polynomial.new([1]).print_poly
