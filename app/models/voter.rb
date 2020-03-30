class Voter < ApplicationRecord
  has_many :votes
  has_many :rooms, dependent: :destroy

  accepts_nested_attributes_for :rooms

  def current_vote_for(poll)
    votes.find_by(poll: poll)
  end

  def host?(room)
    id == room&.host_id
  end
end
