require_relative 'lib/game'
require_relative 'lib/console_interface'

puts 'Hello!'

word = File.readlines("#{__dir__}/data/words.txt", chomp: true).sample

game = Game.new(word)
console_interface = ConsoleInterface.new(game)

until game.over?
  console_interface.print_output

  letter = console_interface.user_input

  game.play!(letter)
end

console_interface.print_output
