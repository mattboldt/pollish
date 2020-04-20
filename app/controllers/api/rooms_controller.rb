class Api::RoomsController < Api::ApplicationController
  def show
    room = Room.find(params[:id])
    render json: Api::RoomSerializer.new(room, include: [:latest_poll, :'latest_poll.options']).serialized_json
  end
end
