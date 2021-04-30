class TransactionsController < ApplicationController
  def index
    @listings = Transaction.available_listings.where.not(user_id: current_user.id).order('created_at desc')
    @listings = Transaction.sell_listings.where.not(user_id: current_user.id) if params[:type] == 'sell'
    @listings = Transaction.buy_listings.where.not(user_id: current_user.id) if params[:type] == 'buy'
    @top10 = Stock.most_active
    @ql = @listings.ransack(params[:ql])
    @q = Stock.ransack(params[:q])
    render :index
    logger.info params
  end

  def show
    @top10 = Stock.most_active
    current_user.admin? ? (@transactions = Transaction.all.order('created_at desc')) : (@transactions = Transaction.where(user_id: current_user.id))
    render :show
  end

  def new
    render :new
  end

  def create
    case params[:transaction_type]
    when 'Buy'
      current_user.buy_stock(Stock.find(params[:stock_id]).code, params[:volume], params[:price])
    when 'Sell'
      current_user.sell_stock(Stock.find(params[:stock_id]).code, params[:volume], params[:price])
    end
  end

  def update
    current_user.process_transaction(@transaction, params[:volume])
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:volume, :user_id, :stock_id, :price, :fulfilled, :transaction_type, :type)
  end
end
