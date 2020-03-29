class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_for Room.find(params[:id])
  end

  def receive(data)
    ActionCable.server.broadcast(Room.find(params[:id]), data)
  end
end
