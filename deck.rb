class Deck
  attr_reader :cards

  CARDS_SUIT = %w[♦ ♣ ♥ ♠].freeze
  CARDS_VALUES = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
    '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [1, 11]
  }.freeze

  def initialize
    @cards = []
  end

  def fill_cards
    CARDS_SUIT.each do |suit|
      CARDS_VALUES.each do |value, score|
        cards << Card.new(value, suit, score)
      end
    end
    cards.shuffle
  end

  def random_card
    cards.sample
  end

  def add_cards(deck_card)
    cards << deck_card
  end

  def remove_cards
    @cards = []
  end

  def cards_scoring
    score = 0
    cards.each do |card|
      score += if card.value == 'A'
                 score > 10 ? card.score.first : card.score.last
               else
                 card.score
               end
    end
    score
  end

  def to_s
    "карты-#{cards.join(',')} очки-#{cards_scoring}"
  end
end
