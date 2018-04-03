class Balance < ApplicationRecord

  def add(amount)
    self.update_attribute(:amount, self.amount+amount)
  end

  def deduct(amount)
    self.update_attribute(:amount, self.amount-amount)
  end
end
