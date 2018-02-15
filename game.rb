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

    check_balance(user)
    check_balance(dealer)

    puts 'Раздача карт:'

    take_cards

    puts "#{user.name}:"
    print_out_cards(user)

    puts "#{dealer.name}:"
    puts 'карты-***** очки-*****'

    pay_to_bank

    current_player = user

    loop do
      if current_player.is_a? User
        break if user.cards.size == 3
        action = select_action
      end
      if current_player.is_a? Dealer
        score = cards_scoring(dealer)
        action = score < 17 ? '2' : '1'
      end
      case action
      when '1'
        puts "#{current_player.name} пропустил ход."
        current_player = rotate(current_player)
      when '2'
        add_card(current_player)
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

    user_score = cards_scoring(user)
    dealer_score = cards_scoring(dealer)

    winner =
      if user_score > dealer_score && user_score <= 21 ||
         user_score == 21 && dealer_score > 21
        user
      elsif dealer_score > user_score && dealer_score <= 21 ||
            dealer_score == 21 && user_score > 21
        dealer
      elsif user_score > 21 && dealer_score > 21 ||
            user_score == dealer_score
        nil
      end

    pay_to_player(winner)

    if winner.nil?
      puts 'Победитель не выявлен, ничья.'
    else
      puts "Победитель: #{winner.name}"
    end
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

  def cards_scoring(player)
    score = 0
    player.cards.each do |card|
      value = if card.value == 'A'
                score > 10 ? 1 : 11
              else
                card.value.to_i
              end
      score += (1..11).cover?(value) ? value : 10
    end
    score
  end

  def add_card(player)
    player.cards << random_card
  end

  def pay_to_bank
    user.balance -= 10
    dealer.balance -= 10
    self.bank += 20
  end

  def pay_to_player(winner)
    if winner.nil?
      user.balance += 10
      dealer.balance += 10
      self.bank -= 20
    else
      winner.balance += bank
      self.bank = 0
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
    player.cards.each { |card| print "#{card.value}#{card.suit} " }
    print 'очки-'
    puts cards_scoring(player)
  end
end
