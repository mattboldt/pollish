class User < ApplicationRecord
  is_voter

  has_many :rooms, dependent: :destroy

  accepts_nested_attributes_for :rooms
end
