class Poll < ApplicationRecord
  belongs_to :room
  has_many :options, dependent: :destroy

  def aggregate
    votes.joins(:option).group('options.name').count
  end

  def self.create_with_room(room, name, options)
    return false if name.blank?

    poll = new(name: name, room: room)
    poll.create_options(options) if poll.save

    poll
  end
end
