class Game
  attr_reader :deck, :user, :dealer
  attr_accessor :bank

  def initialize(deck, user, dealer)
    @deck = deck
    @user = user
    @dealer = dealer
    @bank = 0
  end

  def run
    deck.fill_cards

    check_balance(user)
    check_balance(dealer)

    puts 'Раздача карт:'

    2.times do
      user.deck.add_cards(deck.random_card)
      dealer.deck.add_cards(deck.random_card)
    end

    puts "#{user.name}:"
    print_out_cards(user)

    puts "#{dealer.name}:"
    puts 'карты-***** очки-*****'

    pay_to_bank

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
        1.times do
          current_player.deck.add_cards(deck.random_card)
        end
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
    print_out_cards(user)

    puts "#{dealer.name}:"
    print_out_cards(dealer)

    user_score = user.deck.cards_scoring
    dealer_score = dealer.deck.cards_scoring

    winner =
      if user_score > dealer_score && user_score <= 21 ||
         user_score <= 21 && dealer_score > 21
        user
      elsif dealer_score > user_score && dealer_score <= 21 ||
            dealer_score <= 21 && user_score > 21
        dealer
      elsif user_score > 21 && dealer_score > 21 ||
            user_score == dealer_score
        false
      end

    pay_to_player(winner)

    if winner
      puts "Победитель: #{winner.name}"
    else
      puts 'Победитель не выявлен, ничья.'
    end
  end

  private

  def pay_to_bank
    user.balance -= 10
    dealer.balance -= 10
    self.bank += 20
  end

  def pay_to_player(winner)
    if winner
      winner.balance += bank
      self.bank = 0
    else
      user.balance += 10
      dealer.balance += 10
      self.bank -= 20
    end
  end

  def check_balance(player)
    raise "Не достаточно средств #{player.name}." if player.balance < 10
  end

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

  def print_out_cards(player)
    print 'карты-'
    player.deck.cards.each { |card| print "#{card.value}#{card.suit} " }
    print 'очки-'
    puts player.deck.cards_scoring
  end
end
