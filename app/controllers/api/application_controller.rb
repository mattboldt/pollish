class Api::ApplicationController < ActionController::API
  def current_room
    @current_room ||= Room.find(room_id) if room_id
  end

  def current_voter
    @current_voter ||= if session[:voter_id].present?
      Voter.find_by(id: session[:voter_id].to_i)
    end
  end

  def voter_owns_room?
    current_voter&.id == current_room&.user_id
  end

  def room_id
    params[:room_id].presence || params[:id].presence
  end
end
