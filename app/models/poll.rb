class Poll < ApplicationRecord
  belongs_to :room
  has_many :options, dependent: :destroy
  has_many :votes, through: :options

  accepts_nested_attributes_for :options

  def aggregate
    votes.joins(:option).group('options.name').count
  end
end
