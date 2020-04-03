class Api::PollsController < Api::ApplicationController
  def index
    poll = Poll.where(room: current_room).last
    render json: poll.as_json(include: :options, methods: :aggregate)
  end

  def create
    poll = Poll.create_with_room(current_room, 'New Poll', params[:options])

    if poll
      render json: poll.as_json(include: :options, methods: :aggregate)
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
end
