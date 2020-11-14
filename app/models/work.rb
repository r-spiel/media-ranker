class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true

  has_many :votes

  def top_ten



  end

end
