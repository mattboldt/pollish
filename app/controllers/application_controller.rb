class ApplicationController < ActionController::Base
  helper_method :current_host

  before_action :set_room

  def set_room
    @room = Room.find(params[:id]) if params[:id]
  end

  def current_host
    @current_host ||= begin
      id = cookies[:host_id].to_i

      @room.host if id.present? && @room.present? && @room.host_id == id
    end
  end
end
