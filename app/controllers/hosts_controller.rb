class HostsController < ApplicationController
  def new
    @host = Host.new
    @host.rooms.new
  end

  def create
    @host = Host.new(host_params)

    if @host.save && @host.rooms.last
      cookies[:host_id] = @host.id

      redirect_to @host.rooms.last
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  def show
  end

  private

  def host_params
    params.require(:host).permit(:name, rooms_attributes: [:name])
  end
end
