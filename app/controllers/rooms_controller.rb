class RoomsController < ApplicationController
  before_action :set_room, only: %i(show)

  def new
    @room = current_host.rooms.new
  end

  def create
    @room = current_host.rooms.new(room_params)

    if @room.save
      redirect_to @room
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  def show
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
