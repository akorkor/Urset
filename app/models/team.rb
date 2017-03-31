class Team < ApplicationRecord
  belongs_to :user
  has_many :user_teams

end
