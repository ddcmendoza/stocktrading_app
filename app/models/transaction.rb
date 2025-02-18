class Transaction < ApplicationRecord
  TYPES = %w[Buy Sell].freeze
  belongs_to :user
  belongs_to :stock
  before_save :check_stock_total

  validates :transaction_type, inclusion: { in: TYPES }
  validates :volume, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :available_listings, -> { where(fulfilled: false) }
  scope :sell_listings, -> { available_listings.where("transaction_type = 'Sell'") }
  scope :buy_listings, -> { available_listings.where("transaction_type = 'Buy'") }

  def cancel_transaction
    # Behavior: return alloted_cash/alloted_volume to user => destroy transaction
    case transaction_type
    when 'Buy'
      # Return alloted_cash to cash
      user.alloted_cash = user.alloted_cash - price * volume
      user.cash = user.cash + price * volume
      ActiveRecord::Base.transaction do
        if user.save
          destroy
        else
          'Something went wrong!'
        end
      end

    when 'Sell'
      bs = BuyersStock.find_entry(user.id, stock.id)
      bs.alloted_volume = bs.alloted_volume - volume
      bs.volume = bs.volume + volume
      ActiveRecord::Base.transaction do
        if bs.save
          destroy
        else
          'Something went wrong!'
        end
      end
    end
  end

  def check_stock_total
    stock.check_total
  end

  def opposite_type
    if transaction_type == 'Buy'
      'Sell'
    else
      'Buy'
    end
  end
end
