class RoomsController < ApplicationController
  def show
    @poll = current_room.polls.last
    @new_poll = current_room.polls.build
  end

  private

  def room_params
    params.require(:room).permit(polls_attributes: [])
  end
end
