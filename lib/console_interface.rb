require_relative 'game'
require 'colorize'

class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*txt"].sort.map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_output
    puts <<~INFO
      #{"Word: #{word_to_show}".colorize(:light_blue)}
      #{figure}
      #{"Errors (#{@game.errors_made}): #{errors_to_show}".colorize(:red)}
      #{"You have #{@game.errors_allowed} errors left".colorize(:light_green)}
    INFO
    if @game.won?
      puts 'Congratulations! You  won!'.colorize(:light_green)
    elsif @game.lost?
      puts "You failed... Mystery word: #{@game.word}".colorize(:light_red)
    end
  end

  def figure
    FIGURES[@game.errors_made].colorize(:light_yellow)
  end

  def word_to_show
    @game.letter_to_guess.map { |letter| letter || '__' }.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def user_input
    print 'Enter next letter: '.colorize(:light_white)
    gets[0].upcase
  end
end
