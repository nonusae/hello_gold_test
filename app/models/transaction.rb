class Transaction < ApplicationRecord
  BALANCE_TYPE = ['gold','cash']
  GOLD_TO_CASH_MULTIPLIER = 10

  def execute
    target_balance_type = BALANCE_TYPE.select { |type| type == self.asset }.first
    object_balance_type = BALANCE_TYPE.select { |type| type != self.asset }.first
    target_balance = Balance.find_by_asset_type(target_balance_type)
    object_balance = Balance.find_by_asset_type(object_balance_type)

    if action_type == "top up"
      top_up_amount = self.amount
      target_balance.add(top_up_amount)
    elsif action_type == "buy"
      if target_balance_type == "gold"
        target_balance.add(amount)
        object_balance.deduct(amount*GOLD_TO_CASH_MULTIPLIER)
      else target_balance_type == "cash"
        target_balance.add(amount)
        object_balance.deduct(amount/GOLD_TO_CASH_MULTIPLIER)
      end
    elsif action_type == "sell"
      if target_balance_type == "gold"
        target_balance.deduct(amount)
        object_balance.add(amount*GOLD_TO_CASH_MULTIPLIER)
      else target_balance_type == "cash"
        target_balance.deduct(amount)
        object_balance.add(amount/GOLD_TO_CASH_MULTIPLIER)
      end
    end
  end
end