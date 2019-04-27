#!/usr/bin/env ruby

# Rules for tic tac toe
# It can be played with humans or computer
# Simple user interfaces

WIN_COMBINATIONS = [
  [1,2,3],
  [4,5,6],
  [7,8,9],
  [1,4,7],
  [2,5,8],
  [3,6,9],
  [1,5,9],
  [3,5,7]
]

def display_board(board)
  puts '   |   |   '
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts '   |   |   '
  puts '---|---|---'
  puts '   |   |   '
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts '   |   |   '
  puts '---|---|---'
  puts '   |   |   '
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
  puts '   |   |   '
end

def check_win_combination?(board, player, win_combo)
  win_combo.all? do |position|
    board[position] == player
  end
end

def winner?(board, player)
  WIN_COMBINATIONS.any? do |win_combo|
    check_win_combination?(board, player, win_combo)
  end
end

def full?(board)
  !board.include? ' '
end

def from_one_to_nine?(option)
  (1..9).cover? option.to_i
end

def position_taken?(board, index)
  board[index] == ' '
end

def game_players(game_mode)
  if game_mode == :multi_player
    ['Player 1', 'Player 2']
  elsif game_mode == :single_player
    ['Player 1', 'Computer 1']
  elsif game_mode == :computer
    ['Computer 1', 'Computer 2']
  end
end

def turn_counter(board)
  counters = 0
  board.each do |field|
    counters += 1 if ['X', 'O'].include? field
  end
  counters
end

def current_player(board)
  (turn_counter(board) % 2).zero? ? 'X' : 'O'
end

def player_input(board, game_mode)
  if game_mode == :multi_player || (game_mode == :single_player && current_player(board) == 'X')
    option = gets.chomp
  else
    option = (1..9).to_a.sample
  end
  option.to_i if from_one_to_nine?(option)
end

def game(board, game_mode)
  loop do
    display_board(board)
    players = game_players(game_mode)

    current_player_indicator = current_player(board)
    player = current_player_indicator == 'X' ? players[0] : players[1]

    puts "#{player}, select one cell from 1 to 9"

    option = player_input(board, game_mode)

    while not from_one_to_nine?(option)
      puts 'Your input is not valid. Try again with another option.'
      option = gets.chomp
      option = option.to_i if from_one_to_nine?(option)
    end

    if position_taken?(board, option)
      board[option] = current_player_indicator
    else
      puts 'Option selected, try again with another option'
      next
    end

    if winner?(board, current_player_indicator)
      display_board(board)
      puts "#{current_player_indicator} is the winner!"
      break
    end

    if full?(board)
      display_board(board)
      puts 'Tie!'
      break
    end
  end
end

def game_mode_int_to_symbol(game_mode)
  if game_mode == 1
    :multi_player
  elsif game_mode == 2
    :single_player
  elsif game_mode == 3
    :computer
  end
end

puts 'Tic tac toe'
puts 'Welcome to Tic Tac Toe'

board = ['', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
game_mode = nil

loop do
  puts 'Game modes: '
  puts '1 - Human vs Human'
  puts '2 - Human vs Computer'
  puts '3 - Computer vs Computer'
  game_mode = game_mode_int_to_symbol(gets.chomp.to_i)

  break if [:multi_player, :single_player, :computer].include? game_mode

  puts 'Try again with another option'
end

game(board, game_mode)
