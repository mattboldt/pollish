class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :voter

  OPTIONS = [1, 2, 3, 5].freeze
end
