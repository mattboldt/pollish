class Poll < Tadpoll::Poll
  belongs_to :room

  def aggregate
    votes.group(:value).count
  end
end
