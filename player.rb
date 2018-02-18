class Player
  attr_reader :name, :deck
  attr_accessor :balance

  def initialize(name)
    @name = name
    @balance = 100
    @deck = Deck.new
  end
end
