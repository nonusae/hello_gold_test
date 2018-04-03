require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "#execute" do
    context "when type is top up" do
      context "with gold" do
        let!(:transaction) { Transaction.create( txref:"abcddf", action_type: "top up", asset:"gold", amount: 10.0 ) }
        let!(:gold_balance) { Balance.create(asset_type: "gold", amount: 2.0) }

          it {
            expect { transaction.execute }.to change { gold_balance.reload.amount }.
              from(2.0).
              to(12)
          }
      end

      context "with cash" do
        let!(:transaction) { Transaction.create( txref:"abcddf", action_type: "top up", asset:"cash", amount: 10.0 ) }
        let!(:cash_balance) { Balance.create(asset_type: "cash", amount: 2.0) }

          it {
            expect { transaction.execute }.to change { cash_balance.reload.amount }.
              from(2.0).
              to(12)
          }
      end
    end

    context "when type is buy" do
      context "with gold" do
        let!(:transaction) { Transaction.create( txref:"abcddf", action_type: "buy", asset:"gold", amount: 2.0 ) }
        let!(:gold_balance) { Balance.create(asset_type: "gold", amount: 5.0) }
        let!(:cash_balance) { Balance.create(asset_type: "cash", amount: 1000.0) }

          it {
            expect { transaction.execute }.to change { cash_balance.reload.amount }.
              from(1000.0).
              to(980.0).
              and change { gold_balance.reload.amount }.
              from(5.0).
              to(7.0)
          }
      end

      context "with cash" do
        let!(:transaction) { Transaction.create( txref:"abcddf", action_type: "buy", asset:"cash", amount: 20.0 ) }
        let!(:gold_balance) { Balance.create(asset_type: "gold", amount: 5.0) }
        let!(:cash_balance) { Balance.create(asset_type: "cash", amount: 1000.0) }

          it {
            expect { transaction.execute }.to change { cash_balance.reload.amount }.
              from(1000.0).
              to(1020.0).
              and change { gold_balance.reload.amount }.
              from(5.0).
              to(3.0)
          }
      end
    end

    context "when type is sell" do
      context "with gold" do
        let!(:transaction) { Transaction.create( txref:"abcddf", action_type: "sell", asset:"gold", amount: 2.0 ) }
        let!(:gold_balance) { Balance.create(asset_type: "gold", amount: 5.0) }
        let!(:cash_balance) { Balance.create(asset_type: "cash", amount: 1000.0) }

          it {
            expect { transaction.execute }.to change { cash_balance.reload.amount }.
              from(1000.0).
              to(1020.0).
              and change { gold_balance.reload.amount }.
              from(5.0).
              to(3.0)
          }
      end

      context "with cash" do
        let!(:transaction) { Transaction.create( txref:"abcddf", action_type: "sell", asset:"cash", amount: 20.0 ) }
        let!(:gold_balance) { Balance.create(asset_type: "gold", amount: 5.0) }
        let!(:cash_balance) { Balance.create(asset_type: "cash", amount: 1000.0) }

          it {
            expect { transaction.execute }.to change { cash_balance.reload.amount }.
              from(1000.0).
              to(980.0).
              and change { gold_balance.reload.amount }.
              from(5.0).
              to(7.0)
          }
      end
    end
  end
end
