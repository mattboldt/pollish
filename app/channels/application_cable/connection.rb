module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_voter
    end

    private

    def find_verified_voter
      if (verified_voter = Voter.find_by(id: session[:voter_id]))
        verified_voter
      else
        reject_unauthorized_connection
      end
    end
  end
end
