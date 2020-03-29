class HostsController < ApplicationController
  before_action :set_host, only: %i(new update)

  def new
    @host ||= Host.new
    @room = @host.rooms.new
  end

  def create
    @host = Host.new(host_params)

    if @host.save
      cookies.encrypted[:voter_id] = @host.id

      redirect_to @host.rooms.last
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  def update
    if @host.update(host_params)
      redirect_to @host.rooms.last
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  private

  def host_params
    params.require(:host).permit(:name, rooms_attributes: [:name])
  end

  def set_host
    @host = current_host
  end
end
