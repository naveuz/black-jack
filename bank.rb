class Bank
  attr_accessor :account

  def initialize
    @account = 0
  end

  def pay_to_bank(player)
    player.balance -= 10
    self.account += 10
  end

  def pay_to_player(player)
    player.balance += 10
    self.account -= 10
  end

  def pay_to_winner(winner)
    winner.balance += 20
    self.account = 0
  end

  def check_balance(player)
    raise "Не достаточно средств #{player.name}." if player.balance < 10
  end
end
