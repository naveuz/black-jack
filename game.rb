class Game
  attr_reader :deck, :user, :dealer, :bank

  def initialize(user, dealer)
    @deck = Deck.new
    @user = user
    @dealer = dealer
    @bank = Bank.new
  end

  def run
    user.deck.remove_cards
    dealer.deck.remove_cards

    deck.fill_cards

    bank.check_balance(user)
    bank.check_balance(dealer)

    puts 'Раздача карт:'

    2.times do
      user.deck.add_cards(deck.random_card)
      dealer.deck.add_cards(deck.random_card)
    end

    puts "#{user.name}:"
    puts user.deck

    puts "#{dealer.name}:"
    puts 'карты-***** очки-*****'

    bank.pay_to_bank(user)
    bank.pay_to_bank(dealer)

    current_player = user

    loop do
      if current_player.is_a? User
        break if user.deck.cards.size == 3
        action = select_action
      end
      if current_player.is_a? Dealer
        score = dealer.deck.cards_scoring
        action = score < 17 ? '2' : '1'
      end
      case action
      when '1'
        puts "#{current_player.name} пропустил ход."
        current_player = rotate(current_player)
      when '2'
        current_player.deck.add_cards(deck.random_card)
        puts "#{current_player.name} добавил карту."
        current_player = rotate(current_player)
      when '3'
        break
      else
        puts 'Неверное действие. Попробуйте еще раз.'
      end
    end

    puts 'Открываем карты:'
    puts "#{user.name}:"
    puts user.deck

    puts "#{dealer.name}:"
    puts dealer.deck

    user_score = user.deck.cards_scoring
    dealer_score = dealer.deck.cards_scoring

    winner = select_winner(user_score, dealer_score)

    if winner
      bank.pay_to_winner(winner)
      puts "Победитель: #{winner.name}"
    else
      bank.pay_to_player(user)
      bank.pay_to_player(dealer)
      puts 'Победитель не выявлен, ничья.'
    end
    puts user.balance
    puts dealer.balance
  end

  private

  def rotate(player)
    player == user ? dealer : user
  end

  def select_action
    puts [
      'Выберите действие:',
      '1 - Пропустить',
      '2 - Добавить карту',
      '3 - Открыть карты'
    ]
    gets.chomp
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
