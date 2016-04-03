class Board
	include Enumerable
     
	def initialize(*arg)
		@cellsAlive = arg
	end

	def each(&block)
		@cellsAlive.each(block)
	end
	
	def to_s
		@cellsAlive.join.to_s
	end

	def add_cell(newCell)
		@cellsAlive.push(newCell) unless @cellsAlive.include?(newCell)
	end

	def remove_cell(deadCell)
		@cellsAlive.delete(deadCell)
	end

	def is_alive(cell)
	 @cellsAlive.include?(cell)
	end

    def get_neighbors(cell)
       	
       	cell_row = cell[0]
       	cell_col = cell[1]
         
        neighbors = [[cell_row-1, cell_col-1],[cell_row - 1, cell_col], 
        [cell_row - 1, cell_col + 1],   [cell_row, cell_col + 1],
        [cell_row + 1, cell_col + 1],   [cell_row + 1, cell_col],
        [cell_row + 1, cell_col - 1],   [cell_row, cell_col - 1]]

        neighbors
    end

   def get_alive_neighbors(cell)
    neighbors = get_neighbors(cell)
    alive = 0 
    neighbors.each {|cell| alive += 1 if is_alive(cell)}
    alive
   end

   def keep_cells_from_old_generation()
   	new_gen_cells = []
   	@cellsAlive.each {|cell| new_gen_cells.push(cell) if 
   		(get_alive_neighbors(cell) == 3 || get_alive_neighbors(cell) == 2)  }
   	new_gen_cells
   end

   def get_reborn_cells()

   	reborn_cells = []
     @cellsAlive.each {|cell| 
     get_neighbors(cell).each { |cell|
     reborn_cells.push(cell) if !is_alive(cell) && get_alive_neighbors(cell) == 3 }}

    reborn_cells
   end 

   def get_new_generation()
   	new_generation = keep_cells_from_old_generation + get_reborn_cells
    get_reborn_cells
   end

end

board = Board.new [1, 2], [1, 3], [1, 4] #board[index] = [1,2]?
 #board.add_cell([0,0])
 #puts board.to_s
 board.remove_cell([0,0])
# p board.test_cell([2,3])
 # p board.get_neighbors([1, 2])
 p board.keep_cells_from_old_generation()
 p board.get_new_generation()
# puts board.to_s
#board.test_cell([2,3])
# puts board.to_s