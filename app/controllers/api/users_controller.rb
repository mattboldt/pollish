class Api::UsersController < Api::ApplicationController
  def create
    user = current_user || User.new
    user.attributes = user_params

    session[:user_id] = user.id if user.save

    render json: Api::UserSerializer.new(user).serialized_json
  end

  private

  def user_params
    params.require(:user).permit(:name, rooms_attributes: [:name])
  end
end
