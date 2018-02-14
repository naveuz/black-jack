class Player
  attr_reader :name
  attr_accessor :balance, :cards

  def initialize(name)
    @name = name
    @balance = 100
    @cards = []
  end
end
