class Api::VotesController < Api::ApplicationController
  def create
    poll = Poll.find(params[:poll_id])
    option = poll.options.find(params[:option_id])

    if current_voter.vote_for(option)
      render json: poll.as_json(include: :options, methods: :aggregate)
    else
      head :bad_request
    end
  end
end
