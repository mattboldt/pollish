class VotersController < ApplicationController
  before_action :set_voter, only: %i(new update)

  def new
    @voter ||= Voter.new
    @room = @voter.rooms.new
  end

  def create
    @voter = Voter.new(voter_params)

    if @voter.save
      cookies.encrypted[:voter_id] = @voter.id

      redirect_to current_room || @voter.rooms.last
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  def update
    if @voter.update(voter_params)
      redirect_to @voter.rooms.last
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  private

  def voter_params
    params.require(:voter).permit(:name, rooms_attributes: [:name])
  end

  def set_voter
    @voter = current_voter
  end
end
