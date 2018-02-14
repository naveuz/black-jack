class Game
  attr_reader :deck, :user, :dealer

  def initialize(deck, user, dealer)
    @deck = deck
    @user = user
    @dealer = dealer
  end
end
