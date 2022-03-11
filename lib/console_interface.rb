require_relative 'game'

class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*txt"].sort.map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_output
    puts "Слово: #{word_to_show}
         #{figure}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}"
    if @game.won?
      puts 'Congratulations! You  won!'
    elsif @game.lost?
      puts "You failed... Mystery word: #{@game.word}"
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    @game.letter_to_guess.map { |letter| letter || '__' }.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def user_input
    print 'Enter next letter: '
    gets[0].upcase
  end
end
