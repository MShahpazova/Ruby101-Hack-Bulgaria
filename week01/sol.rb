
def num_to_array(num)
  arrayInts = num.to_s.split('')
  arrayInts.reverse
end


def find_min_element(numbers)
	numbers.min
	
end
#p num_to_array [1, 2, 7]

def find_nth_min_el(numbers, index)
	numbers.uniq.sort[index]
end

# p ARGV
# p find_nth_min_el(eval(ARGV[0]), ARGV[1].to_i)

# p find_nth_min_el([1, 2, 3, 4], ARGV[0].to_i)
def sum_matrix(matrix)
	row_index, col_index = 0,0
	result = 0
	while row_index < matrix.length
		col_index = 0
		while col_index < matrix[row_index].length
			
			result += matrix[row_index][col_index]
			col_index +=1
		end
		row_index += 1
	end
	result
	#m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
end
#puts sum_matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
def grey_scale_image_histogram(image)
	histogram = Array.new(256, 0)

	count_row, count_col = 0,0
	while 
		count_row < image.length
		count_col = 0
		while count_col < image[count_row].length
			index = image[count_row][count_col]
			histogram[index] += 1
			count_col += 1
		end
		count_row += 1
	end
	histogram
end
image = [[0, 0, 0, 0, 0],
         [111, 255, 0, 0, 111],
         [100, 100, 100, 100, 100],
         [1, 1, 1, 1, 1],
         [3, 3, 5, 6, 9]]

result = grey_scale_image_histogram(image)
# p result[0]
# p result[1]
# p result[3]
# p result[5]
# p result[9]
# p result[100]
# p result[111]
# p result[255]
def largest_hash_key(hash)
  hash.max_by{|k,v| v}
end

def max_span(num_arr)
	spans = Hash.new(0)
	index1 = 0
	index2 = 1
	indexOfNextNum = 0
	
	while index1 < num_arr.count/2 + num_arr.count % 2
		thereIsSpan = false
		num = num_arr[index1]
		index2 = index1 + 1
		while index2 < num_arr.count
			if num == num_arr[index2] 
			indexOfNextNum = index2	
			thereIsSpan = true
			end
			index2 += 1	
		end
		
		if thereIsSpan
			span = indexOfNextNum + 1 - index1
			if spans.has_key?(num)
				current_value = spans[num]
				if span > current_value
					spans.store(num, span)
				end
			else 
				spans.store(num, span)
			end
		end
	indexOfNextNum = 0
     index1 += 1
	end
	largest_hash_key(spans)
	a, b = spans.max_by{|k,v| v}
	result = "#{a} => #{b}"
end

#number = [1, 2, 1, 1, 3]
#number = [3, 3, 3, 1, 4, 1, 1]
# number = [1, 4, 2, 1, 4, 4, 4]
# result = max_span(number)
# puts result

# def longest_subsequence_equal_elements(m)
# 	allValues = m.join("")
# 	uniqueValues = m.uniq.join("")
#     count = 0
# 	while count < uniqueValues.length
# 		char = uniqueValues[count]
#         #a = allValues.scan([uniqueValues[count])
# 		#a = allValues.scan("/"+"["+char+"]"+"+"+"/")
# 		a = allValues.scan(/[#{char}]+/)
# 		puts a
# 		#puts a.count
# 		count += 1
# 	end

# 	#puts mat
# end
def group_objects(m)
  count = 0
  result = []
  temp_arr = []
  seq = false
  while(count < m.length)
  	if seq == false
  	temp_arr.push(m[count])
  	end
  	if m[count].eql?m[count+1]
  		puts m[count]
  		temp_arr.push(m[count+1])
  		seq = true
  	else
     result.push(temp_arr)
     # puts temp_arr.join
     temp_arr = []
     seq = false
  	end
  	count += 1
  end
  p result
end

def deploy_bomb(*args, m)
	row = args[0]
    col = args[1]
    matrix = m
    rows = m.length
    cols = m[0].length
    bomb_strength = matrix[row][col]
    if row - 1 >= 0
       matrix[row-1][col] -= bomb_strength    	
    end
    if row + 1 < matrix.length
    	matrix[row+1][col] -= bomb_strength
    end

    if col+1 < matrix[row].length
    	matrix[row][col+1] -= bomb_strength
    end

	if col - 1 >= 0
		matrix[row][col-1] -= bomb_strength
	end

	if row - 1 >= 0 && col - 1 >= 0
		matrix[row-1][col-1] -= bomb_strength
	end
	if row + 1 < matrix.length && col - 1 >= 0
		matrix[row + 1][col - 1] -= bomb_strength
	end
	if row + 1 < matrix.length && col + 1 < matrix[row].length
		matrix[row + 1][col + 1] -= bomb_strength
	end
	if row - 1 >= 0 && col + 1 < matrix[row].length
		matrix[row -1 ][col + 1] -= bomb_strength
	end
	(0..rows - 1).each {|r| (0..cols - 1).each {|c| matrix[r][c] = 0 if matrix[r][c] < 0}}
	 # puts (0..rows-1).each {|r| puts matrix[r].join} 
	 # puts "\n"
	matrix
	
end

def draw_matrix()
	rows, cols = 3,3
	grid = Array.new(rows) {Array.new(cols)}
	#(0..rows - 1).each {|r| (0..cols - 1).each {|c| grid[r][c] = 10} }
	count = 1
	(0..rows - 1).each {|r| (0..cols - 1).each {|c| grid[r][c] = count; count += 1} }
	#grid[1][1] = 9
	# (0..rows-1).each {|r| (0..cols-1).each{|c| puts grid[r].join} }
    #(0..rows-1).each {|r| puts grid[r].join(" ")}
    #deploy_bomb(1,1, grid)
    #(0..rows-1).each {|r| puts grid[r].join(" ")}
    #p grid
	#why not do end???
	grid
end

def calculate_damage(*arg, m)
	row = arg[0]
	col = arg[1]
	rows = m.length
	cols = m[0].length
	result_matrix = deploy_bomb(row, col, m)
	count_damage = 0
	(0..rows - 1).each {|r| (0..cols - 1).each {|c| count_damage += result_matrix[r][c]}}
	count_damage
end

def bombing_plan(m)
	rows = m.length
	cols = m[0].length
	hash = {}
	(0..rows - 1).each {|r| (0..cols - 1).each {|c| key = [r,c] ; hash[key] = calculate_damage(r,c,draw_matrix());}}
	hash
end
     # draw_matrix
   # puts deploy_bomb(2,2, draw_matrix)
    #puts calculate_damage(1,1, draw_matrix)
    puts bombing_plan(draw_matrix)
	#matrix.map!(|col| col = [10,10,10])
	# matrix = [[10,10,10], [10,10,10], [10, 10,10]]
	# row = arguments[0]
	# col = arguments[1]
	# puts row
	# puts col
	# matrix.column(0)??
	#puts matrix.row(0)??
    # rows, cols = x,y  # your values
    # grid = Array.new(rows) { Array.new(cols) }
	
	# p matrix[0][1]

#m = [[10,10,10], [10,10,10],10, 10,10]]
#m = [1, 2, 3, 3, 3, 3, 4, 3, 3]
# def longest_subsequence_equal_elements(m)
# 	list = []
# 	allValues = m.join("")
# 	uniqueValues = m.uniq.join("")
#     count = 0
# 	while count < uniqueValues.length
# 		char = uniqueValues[count]
# 		a = allValues.scan(/[#{char}]+/)
# 		#puts a
# 		#puts a.count
# 		a.each {|element| list.push(element.split())}
# 		count += 1
# 	end

#    result = []
#    list.each{|element| 
#    	puts element; 
#    	if element.length > 1
#    	result.push(element.split()) 
#    else
#     result.push(element.to_a)
#     end
#     }
#    p result
# end

# m =[1, 2, 3, 3, 3, 3, 4, 3, 3]
 #p group_objects(m)

#m = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]