class Api::UsersController < Api::ApplicationController
  before_action :set_user, only: %i(new update)

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      render json: { user: @user, room_id: (current_room || @user.rooms.last).hashid }
    else
      render json: { user: @user }, status: :bad_request
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user.rooms.last
    else
      flash.now[:error] = 'Could not create room'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, rooms_attributes: [:name])
  end

  def set_user
    @user = current_user
  end
end
