class ApplicationController < ActionController::Base
  helper_method :current_voter, :current_room, :voter_owns_room?

  def current_room
    @current_room ||= Room.find(room_id) if room_id
  end

  def current_voter
    @current_voter ||= if cookies.encrypted[:voter_id].present?
      Voter.find_by(id: cookies.encrypted[:voter_id].to_i)
    end
  end

  def voter_owns_room?
    current_voter&.id == current_room&.voter_id
  end

  def room_id
    params[:room_id].presence || params[:id].presence
  end
end
