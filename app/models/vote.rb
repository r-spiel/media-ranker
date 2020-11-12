class Vote < ApplicationRecord
  #validate that user & work are unique

  belongs_to :user
  belongs_to :work
end
