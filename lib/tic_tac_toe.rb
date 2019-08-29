def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn_count(board)
  occupied = 0
  turn_counter = board.each do |position|
    if position == "X" || position == "O"
    occupied += 1
    end
    end
  occupied
end

def current_player(board)
  (turn_count(board) % 2 == 0? "X" : "O")
end

def move(board,index,player)
  board[index] = player
end

def position_taken?(board,index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
    else 
    return true
  end
end

def valid_move?(board,index)
  if position_taken?(board,index) == false && index.between?(0,8)
    return true
    else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  player = current_player(board)
  if valid_move?(board,index) == true 
    move(board,index,player)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  until over?(board) || draw?(board)
  turn(board)
  end
  if draw?(board)
  puts "Cat's Game!"
  else
  puts "Congratulations #{winner(board)}!"
  end
end

# Game Outcomes: Win / Draw

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Right column
  [1,4,7], # Middle column
  [2,5,8], # Left column
  [0,4,8], # Diagonal 1
  [2,4,6]  # Diagonal 2
  ]
  
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|i| board[i] == "X"}
      return combo
    elsif combo.all? {|i| board[i] == "O"}
      return combo
    end
    end
  nil
end

def full?(board)
  board.all?{|character| character == "X" || character == "O"}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end