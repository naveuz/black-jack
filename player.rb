class Player
  attr_reader :balance, :score, :cards

  def initialize
    @balance = 100
    @score = 0
    @cards = []
  end
end
