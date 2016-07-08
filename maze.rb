class Maze

 def initialize(maze)
	@maze = []
	maze.split("\n").each do | row |
		row = row.chars.to_a
		@maze << row
	end
	@visited = Array.new(@maze.length){Array.new(@maze[0].length)}	
	for i in 0...@visited.length
		for j in 0...@visited[i].length
			@visited[i][j] = false
		end
	end
	is_solvable_util
  end


  def display_maze
	@maze.each do | row |
	    row.each do | elem |
		print elem
	    end
	    print "\n"
	end
  end

  private 
  def is_solvable_dfs(i,j)    #using dfs
        	if ( i < 0 || i >= @maze.length || j < 0 || j >= @maze[0].length )
  		 return false;
		end
		if(!@visited[i][j])
			@visited[i][j] = true
			if ( @maze[i][j] == '#')
				return false
			end
			if ( @maze[i][j] == 'B' )
				return true
			else  			
 				return (is_solvable(i-1,j) || is_solvable(i+1,j) || is_solvable(i,j-1) || is_solvable(i,j+1) ) 
  			end
		end
		return false
  end


  public	
  def solvable?    #using bfs
  	start  = [ @sx , @sy, 0 ]
	queue = Queue.new
	queue.push(start)

	while !queue.empty?
		node = queue.pop
		xs = [ -1 , 1, 0 , 0]
		ys = [ 0, 0, -1 , 1 ]
        	for i in (0...4)
			x = node[0] + xs[i]
			y = node[1] + ys[i]
			if  ( x >=0 && x < @maze.length ) && ( y >= 0 && y < @maze[0].length ) && @maze[x][y] != '#' && !@visited[x][y]
				@visited[x][y] = true
				point = []
				k = node[2] + 1
				point << x << y << k
				if @maze[x][y] == 'B'
					return true
				end
				queue.push(point)
			end 
		end
	end	
	return false			
  end

 def steps    #using bfs
        start  = [ @sx , @sy, 0 ]
        queue = Queue.new
        queue.push(start)
	for i in 0...@visited.length
                for j in 0...@visited[i].length
                        @visited[i][j] = false
                end
        end
        while !queue.empty?
                node = queue.pop
                xs = [ -1 , 1, 0 , 0]
                ys = [ 0, 0, -1 , 1 ]
                for i in (0...4)
                        x = node[0] + xs[i]
                        y = node[1] + ys[i]
                        if  ( x >=0 && x < @maze.length ) && ( y >= 0 && y < @maze[0].length ) && @maze[x][y] != '#' && !@visited[x][y]
                                @visited[x][y] = true
                                point = []
                                k = node[2] + 1
                                point << x << y << k
                                if @maze[x][y] == 'B'
                                        return k
                                end
                                queue.push(point)
                        end
                end
        end
	return 0
  end

  public
  def is_solvable_util
	for i in 0...@maze.length
	    for j in 0...@maze[i].length
		if @maze[i][j] == 'A'
			@visited[i][j] = true
			@sx = i
			@sy = j
			break
		end
	    end
	end
  end
end



=begin
#input mazes
Maze1 = %{#####################################
# #   #     #A        #     #       #
# # # # # # ####### # ### # ####### #
# # #   # #         #     # #       #
# ##### # ################# # #######
#     # #       #   #     # #   #   #
##### ##### ### ### # ### # # # # # #
#   #     #   # #   #  B# # # #   # #
# # ##### ##### # # ### # # ####### #
# #     # #   # # #   # # # #       #
# ### ### # # # # ##### # # # ##### #
#   #       #   #       #     #     #
#####################################}



maze1 = Maze.new(Maze1)
maze1.display_maze

if maze1.solvable? == true
	puts "MAZE1 is solvable in #{maze1.steps}"
else
	puts "MAZE1 cannot be solved"
end

Maze2 = %{#####################################
# #       #             #     #     #
# ### ### # ########### ### # ##### #
# #   # #   #   #   #   #   #       #
# # ###A##### # # # # ### ###########
#   #   #     #   # # #   #         #
####### # ### ####### # ### ####### #
#       # #   #       # #       #   #
# ####### # # # ####### # ##### # # #
#       # # # #   #       #   # # # #
# ##### # # ##### ######### # ### # #
#     #   #                 #     #B#
#####################################}

maze2 = Maze.new(Maze2)
maze2.display_maze

if maze2.solvable? == true
	puts "MAZE2 is solvable in #{maze2.steps}"
else
	puts "MAZE2 cannot be solved"
end

Maze3 = %{#####################################
# #   #           #                 #
# ### # ####### # # # ############# #
### ##### ### ####### # ##### ### # #
# #       # #  A  #   #       #   # #
# ######### ##### # ####### ### ### #
#               ###       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     #B#   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #   #           #
#####################################}


maze3 = Maze.new(Maze3)
maze3.display_maze

if maze3.solvable? == true
	puts "MAZE3 is solvable in #{maze3.steps}"
else
	puts "MAZE3 cannot be solved"
end
=end
