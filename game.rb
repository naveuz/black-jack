class Game
  attr_reader :deck, :user, :dealer, :bank, :interface

  def initialize(user, dealer)
    @deck = Deck.new
    @user = user
    @dealer = dealer
    @bank = Bank.new
    @interface = Interface.new
  end

  def run
    user.deck.remove_cards
    dealer.deck.remove_cards

    deck.fill_cards

    bank.check_balance(user)
    bank.check_balance(dealer)

    interface.take_cards
    2.times do
      user.deck.add_cards(deck.random_card)
      dealer.deck.add_cards(deck.random_card)
    end
    interface.print_cards(user)
    interface.print_cards_hidden(dealer)

    bank.pay_to_bank(user)
    bank.pay_to_bank(dealer)

    current_player = user

    loop do
      if current_player.is_a? User
        break if user.deck.cards.size == 3
        action = interface.select_action
      end
      if current_player.is_a? Dealer
        score = dealer.deck.cards_scoring
        action = score < 17 ? '2' : '1'
      end
      case action
      when '1'
        interface.skip_step(current_player)
        current_player = rotate(current_player)
      when '2'
        current_player.deck.add_cards(deck.random_card)
        interface.added_card(current_player)
        current_player = rotate(current_player)
      when '3'
        break
      else
        interface.wrong_action
      end
    end

    interface.open_cards
    interface.print_cards(user)
    interface.print_cards(dealer)

    user_score = user.deck.cards_scoring
    dealer_score = dealer.deck.cards_scoring

    winner = select_winner(user_score, dealer_score)

    if winner
      bank.pay_to_winner(winner)
      interface.print_winner(winner)
    else
      bank.pay_to_player(user)
      bank.pay_to_player(dealer)
      interface.print_not_winner
    end
  end

  private

  def rotate(player)
    player == user ? dealer : user
  end

  def select_winner(user_score, dealer_score)
    if user_score > dealer_score && user_score <= 21 ||
       user_score <= 21 && dealer_score > 21
      user
    elsif dealer_score > user_score && dealer_score <= 21 ||
          dealer_score <= 21 && user_score > 21
      dealer
    elsif user_score > 21 && dealer_score > 21 ||
          user_score == dealer_score
      nil
    end
  end
end
