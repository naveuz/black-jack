require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'bank'
require_relative 'game'
require_relative 'interface'

interface = Interface.new
user = User.new(interface.select_name)
dealer = Dealer.new('Дилер')

loop do
  game = Game.new(user, dealer)

  game.run

  break if interface.repeat_game == 'нет'
end
