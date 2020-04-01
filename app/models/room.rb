class Room < ApplicationRecord
  include Hashid::Rails

  belongs_to :host, class_name: 'User', foreign_key: :user_id, optional: true
  has_many :polls, dependent: :destroy

  accepts_nested_attributes_for :polls
end
