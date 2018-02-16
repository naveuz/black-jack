class Card
  attr_reader :value, :suit, :score

  def initialize(value, suit, score)
    @value = value
    @suit = suit
    @score = score
  end
end
