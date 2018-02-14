class Game
  attr_reader :deck, :user, :dealer
  attr_accessor :bank

  def initialize(user, dealer)
    @user = user
    @dealer = dealer
    @bank = 0
  end

  def run
    @deck = Deck.new

    reset

    take_cards

    print "#{user.name}: "
    print 'карты - '
    user.cards.each { |card| print "#{card.value}#{card.suit} " }
    print 'очки - '
    print cards_scoring(user.cards)
    puts ''
    print "#{dealer.name}: "
    print 'карты - '
    dealer.cards.each { |card| print "#{card.value}#{card.suit} " }
    print 'очки - '
    print cards_scoring(dealer.cards)
    puts ''
  end

  private

  def random_card
    idx = rand(deck.cards.size)
    deck.cards[idx]
  end

  def reset
    user.cards = []
    dealer.cards = []
  end

  def take_cards
    2.times do
      user.cards << random_card
      dealer.cards << random_card
    end
  end

  def cards_scoring(cards)
    score = 0
    cards.each do |card|
      value = if card.value == 'A'
                score > 10 ? 1 : 11
              else
                card.value.to_i
              end
      score += (1..11).include?(value) ? value : 10
    end
    score
  end

  def pay_to_bank
    user.balance -= 10
    dealer.balance -= 10
    self.bank += 20
  end

  def pay_to_player

  end

  def check_balance

  end
end
