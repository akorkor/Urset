class Player < ApplicationRecord
  belongs_to :user
  has_many :user_players

end
