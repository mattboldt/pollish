class Poll < ApplicationRecord
  belongs_to :room
  has_many :votes, dependent: :destroy

  accepts_nested_attributes_for :votes, allow_destroy: true

  def aggregate
    votes.group(:value).count
  end
end
