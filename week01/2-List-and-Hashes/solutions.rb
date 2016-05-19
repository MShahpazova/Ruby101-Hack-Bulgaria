def number_to_digits(n)
  n.to_s.chars.map(&:to_i)
end

def digits_to_number(digits)
  digits.reduce(0) { |a, e| a * 10 + e }
end

def max_scalar_product(v1, v2)
  v1 = v1.sort
  v2 = v2.sort

  v1.each_with_index
    .map { |x, i| x * v2[i] }
    .reduce(&:+)
end

def sum_marix(m)
  m.map { |row| row.reduce(&:+) }.reduce(&:+)
end

def num_to_array(num)
  array_ints = num.to_s.split('')
  array_ints.reverse
end

def find_min_element(numbers)
  numbers.min
end

def find_nth_min_el(numbers, index)
  numbers.uniq.sort[index]
end

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
end

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
  (0..rows - 1).each do
   |r| (0..cols - 1).each do |c|
   matrix[r][c] = 0 if matrix[r][c] < 0
    end
  end
end

def draw_matrix()
  rows, cols = 3,3
  grid = Array.new(rows) {Array.new(cols)}
  count = 1
  (0..rows - 1).each do |r|
  (0..cols - 1).each do |c| 
  grid[r][c] = count
  count += 1
    end
  end
  grid
end

def calculate_damage(*arg, m)
  row = arg[0]
  col = arg[1]
  rows = m.length
  cols = m[0].length
  result_matrix = deploy_bomb(row, col, m)
  count_damage = 0
  (0..rows - 1).each do |r|
    (0..cols - 1).each do |c| 
    count_damage += result_matrix[r][c]
   end
  end
  count_damage
end

def bombing_plan(m)
  rows = m.length
  cols = m[0].length
  hash = {}
  (0..rows - 1).each do |r|
  (0..cols - 1).each do |c|
  key = [r,c] 
  hash[key] = calculate_damage(r,c,draw_matrix())
  hash
end

puts group_objects([1, 1, 1, 2, 3, 1, 1])