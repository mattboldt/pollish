class Room < ApplicationRecord
  include Hashid::Rails

  belongs_to :host, class_name: 'User', foreign_key: :user_id, optional: true
  has_many :polls, dependent: :destroy
  has_one :latest_poll, -> { order(:created_at) }, class_name: 'Poll'

  accepts_nested_attributes_for :polls
end
