require 'rails_helper'

RSpec.describe Balance, type: :model do
  describe "#add" do
    let(:balance) { Balance.create(asset_type:"gold", amount: 10)}
    it { expect { balance.add(2) }.to change { balance.reload.amount}.
          from(10).
          to(12)
      }
  end

  describe "#deduct" do
    let(:balance) { Balance.create(asset_type:"gold", amount: 10)}
    it { expect { balance.deduct(2)}.to change { balance.reload.amount}.
          from(10).
          to(8)
      }
  end
end
