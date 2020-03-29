class ApplicationController < ActionController::Base
  helper_method :current_host, :current_room, :host_owns_room?

  def current_room
    @current_room ||= Room.find(params[:id]) if params[:id]
  end

  def current_host
    if cookies.encrypted[:voter_id].present?
      @current_host ||= Host.find(cookies.encrypted[:voter_id].to_i)
    end
  end

  def host_owns_room?
    current_host&.id == current_room&.host_id
  end
end
