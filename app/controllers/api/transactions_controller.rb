module Api
  class TransactionsController < ApplicationController
    def index
      @transactions = Transaction.all
      render json: { transactions: @transactions }
    end

    def top_up
      amount = params[:amount]
      asset_type = params[:asset]
      transaction = Transaction.new
      transaction.txref = "asdf"
      transaction.action_type = "top up"
      transaction.amount = amount.to_f
      transaction.asset = asset_type
      if transaction.save
        transaction.execute
        render json: { result: "OK"}
      end
    end

    def buy
      amount = params[:amount]
      asset_type = params[:asset]
      transaction = Transaction.new
      transaction.txref = "asdf"
      transaction.action_type = "buy"
      transaction.amount = amount.to_f
      transaction.asset = asset_type
      if transaction.save
        transaction.execute
        render json: { result: "OK"}
      end
    end

    def sell
      amount = params[:amount]
      asset_type = params[:asset]
      transaction = Transaction.new
      transaction.txref = "asdf"
      transaction.action_type = "sell"
      transaction.amount = amount.to_f
      transaction.asset = asset_type
      if transaction.save
        transaction.execute
        render json: { result: "OK"}
      end
    end
  end
end