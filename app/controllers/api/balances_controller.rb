module Api
  class BalancesController < ApplicationController
    def index
      gold_amount = Balance.find_by_asset_type('gold').amount
      cash_amount = Balance.find_by_asset_type('cash').amount
      render json: { GLD:gold_amount,
                     CASH:cash_amount }
    end
  end
end