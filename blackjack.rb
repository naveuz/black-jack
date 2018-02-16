require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'game'

puts 'Как ваше имя?'

name = gets.chomp

loop do
  game = Game.new(Deck.new, User.new(name), Dealer.new('Дилер'))

  game.run

  puts 'Хотите сыграть еще раз? (да/нет)'
  break if gets.chomp == 'нет'
end
