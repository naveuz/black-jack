require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'bank'
require_relative 'game'

puts 'Как ваше имя?'

name = gets.chomp
user = User.new(name)
dealer = Dealer.new('Дилер')

loop do
  game = Game.new(user, dealer)

  game.run

  puts 'Хотите сыграть еще раз? (да/нет)'
  break if gets.chomp == 'нет'
end
