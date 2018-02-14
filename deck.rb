class Deck
  attr_reader :cards

  CARDS_SUIT = %w[♦ ♣ ♥ ♠].freeze
  CARDS_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize
    @cards = fill_cards
  end

  private

  def fill_cards
    cards = []
    CARDS_SUIT.each do |suit|
      CARDS_VALUES.each do |value|
        cards << Card.new(value, suit)
      end
    end
    cards.shuffle
  end
end
