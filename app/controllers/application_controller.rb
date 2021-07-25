class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :json_request?
  protect_from_forgery with: :null_session, if: :json_request?
  skip_before_action :verify_authenticity_token, if: :json_request?
  rescue_from ActionController::InvalidAuthenticityToken,
              with: :invalid_auth_token
  before_action :set_current_user, if: :json_request?

  $balances = ''

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || assets_path
  end

  private

  def json_request?
    request.format.json?
  end

  # Use api_user Devise scope for JSON access
  def authenticate_user!(*args)
    super and return unless args.blank?
    $balances = current_user.avg_balances if $balances.blank?
    json_request? ? authorize_request : super
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JWT.decode(header, ENV["SECRET_KEY_BASE"])
      @current_user = User.find(@decoded.first['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def find_user
    @user = User.find_by_email!(params[:_email])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Usuario no econtrado' }, status: :not_found
  end


  # So we can use Pundit policies for api_users
  def set_current_user
    @current_user ||= warden.authenticate(scope: :api_user)
  end
end