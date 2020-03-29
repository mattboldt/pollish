module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_voter

    def connect
      self.current_voter = find_verified_voter
    end

    private

    def find_verified_voter
      if (verified_voter = Voter.find_by(id: cookies.encrypted[:voter_id]))
        verified_voter
      else
        reject_unauthorized_connection
      end
    end
  end
end
