#!/usr/bin/env ruby

# Rules for tic tac toe
# It can be played with humans or computer
# Simple user interfaces

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

def winner?(board, player)
  (board[1] == player && board[2] == player && board[3] == player) ||
  (board[4] == player && board[5] == player && board[6] == player) ||
  (board[7] == player && board[8] == player && board[9] == player) ||
  (board[1] == player && board[4] == player && board[7] == player) ||
  (board[2] == player && board[5] == player && board[8] == player) ||
  (board[3] == player && board[6] == player && board[9] == player) ||
  (board[1] == player && board[5] == player && board[9] == player) ||
  (board[3] == player && board[5] == player && board[7] == player)
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
  if game_mode == 1
    ['Player 1', 'Player 2']
  elsif game_mode == 2
    ['Player 1', 'Computer 1']
  elsif game_mode == 3
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
  if game_mode == 1 || (game_mode == 2 && current_player(board) == 'X')
    option = gets.chomp
  else
    option = (1..9).to_a.sample
  end
  option.to_i if from_one_to_nine?(option)
end

def game(board, game_mode)
  display_board(board)
  loop do
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

puts 'Tic tac toe'
puts 'Welcome to Tic Tac Toe'

board = ['', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
game_mode = 0

loop do
  puts 'Game modes: '
  puts '1 - Human vs Human'
  puts '2 - Human vs Computer'
  puts '3 - Computer vs Computer'
  game_mode = gets.chomp.to_i
  break if [1, 2, 3].include? game_mode

  puts 'Try again with another option'
end

game(board, game_mode)
