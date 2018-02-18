class Interface
  def select_name
    puts 'Как ваше имя?'
    gets.chomp
  end

  def repeat_game
    puts 'Хотите сыграть еще раз? (да/нет)'
    gets.chomp
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

  def print_cards(player)
    puts "#{player.name}:"
    puts player.deck
  end

  def print_cards_hidden(player)
    puts "#{player.name}:"
    puts 'карты-***** очки-*****'
  end

  def take_cards
    puts 'Раздача карт:'
  end

  def open_cards
    puts 'Открываем карты:'
  end

  def skip_step(player)
    puts "#{player.name} пропустил ход."
  end

  def added_card(player)
    puts "#{player.name} добавил карту."
  end

  def wrong_action
    puts 'Неверное действие. Попробуйте еще раз.'
  end

  def print_winner(winner)
    puts "Победитель: #{winner.name}"
  end

  def print_not_winner
    puts 'Победитель не выявлен, ничья.'
  end
end
