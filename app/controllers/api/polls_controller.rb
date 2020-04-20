class Api::PollsController < Api::ApplicationController
  def create
    poll = current_room.polls.new(poll_params)

    if poll.save
      render json: Api::PollSerializer.new(poll).serialized_json
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
    params.require(:poll).permit(options_attributes: [:name])
  end
end
