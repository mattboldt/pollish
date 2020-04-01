class Api::PollsController < Api::ApplicationController
  def create
    if (poll = current_room.polls.create)
      render json: poll
    else
      head :bad_request
    end
  end

  def update
    poll = Poll.find(params[:id])

    if poll.update(poll_params)
      render json: poll
    else
      head :bad_request
    end
  end

  private

  def poll_params
    params.permit(votes_attributes: %i(id value voter_id))
  end
end
