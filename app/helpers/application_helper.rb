module ApplicationHelper
  def app_context
    {
      current_room: current_room,
      current_voter: current_voter,
      voter_owns_room: voter_owns_room?,
      room_id: room_id
    }
  end

  def current_room
    @current_room ||= Room.find(room_id) if room_id
  end

  def current_voter
    @current_voter ||= if session[:user_id].present?
      User.find_by(id: session[:user_id].to_i)
    end
  end

  def voter_owns_room?
    current_voter&.id == current_room&.user_id
  end

  def room_id
    params[:room_id].presence
  end
end
