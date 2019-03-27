#!/usr/bin/env ruby

# Rules for tic tac toe
# It can be played with humans or computer
# Simple user interfaces
puts 'Tic tac toe'

board = ['', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

def way_to_win(board, player, pos_1, pos_2, pos_3)
  board[pos_1] == player && board[pos_2] == player && board[pos_3] == player
end

def show_board(board)
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
  way_to_win(board, player, 1, 2, 3) || way_to_win(board, player, 4, 5, 6) ||
  way_to_win(board, player, 7, 8, 9) || way_to_win(board, player, 1, 4, 7) ||
  way_to_win(board, player, 2, 5, 8) || way_to_win(board, player, 3, 6, 9) ||
  way_to_win(board, player, 1, 5, 9) || way_to_win(board, player, 3, 5, 7)
end

def full?(board)
  !board.include? ' '
end

while true do
  show_board(board)

  puts 'Player 1, select one cell from 1 to 9'
  option = gets.chomp.to_i

  if board[option] == ' '
    board[option] = 'X'
  else
    puts 'Option selected, try again with another option'
  end

  # Check if player 1 wins
  if winner?(board, 'X')
    show_board(board)
    puts 'X is the winner!'
    break
  end

  # Check for a tie
  if full?(board)
    show_board(board)
    puts 'Tie!'
    break
  end

  show_board(board)

  puts 'Player 2, select one cell from 1 to 9'
  option = gets.chomp.to_i

  if board[option] == ' '
    board[option] = 'O'
  else
    puts 'Option selected, try again with another option'
  end

  # Check if player 2 wins
  if winner?(board, 'O')
    show_board(board)
    puts 'O is the winner!'
    break
  end

  if full?(board)
    show_board(board)
    puts 'Tie!'
    break
  end
end
