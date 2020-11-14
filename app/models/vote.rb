class Vote < ApplicationRecord
  validates :user, uniqueness: {scope: :work}
  #do I also have to validate the reverse?

  belongs_to :user
  belongs_to :work

  def num_votes

  end
end
