class Vote < ApplicationRecord
  validates :user, uniqueness: {scope: :work, message: "has already voted for this work"}

  belongs_to :user
  belongs_to :work
end
