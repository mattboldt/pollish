class User < ApplicationRecord
  has_many :rooms, dependent: :destroy

  accepts_nested_attributes_for :rooms

  def latest_room_id
    rooms.last.hashid
  end
end
