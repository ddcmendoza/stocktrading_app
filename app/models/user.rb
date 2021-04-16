class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_and_belongs_to_many :role, foreign_key: "role_id"
    has_and_belongs_to_many :stock, join_table: "buyers_stocks", foreign_key: "stock_id"
end
