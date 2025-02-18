class ApplicationController < ActionController::Base
  before_action :update_allowed_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  add_flash_types :success, :info, :warning, :danger

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :role_id, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :reset_password_token) }
  end
end

#     require 'iex-ruby-client'
#     Use for IEX
#     @client = IEX::Api::Client.new(
#         publishable_token: "#{ENV['IEX_API_PUBLISHABLE_TOKEN']}",
#         secret_token: "#{ENV['IEX_API_SECRET_TOKEN']}",
#         endpoint: "https://cloud.iexapis.com/v1"
#     )
#    # @quote = @client.quote('MSFT')
#     @test_print ="TEST" #"#{@quote.latest_price}, #{@quote.change}, #{@quote.change_percent}, #{@quote.change_percent_s}"
#     @historial_prices = @client.ref_data_symbols #@client.historical_prices('MSFT')

#     #historial_price = @historial_prices.first
#     #@test = historial_price.open
