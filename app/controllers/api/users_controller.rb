class Api::UsersController < Api::BaseController

  before_action :find_user, only: %w[show]

  def show
    render_jsonapi_response(@user)
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    render json: @user
  end

end