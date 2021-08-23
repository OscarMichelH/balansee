class Api::SessionsController < Devise::SessionsController
  # I'm guessing this isn't required since we don't track signed in/signed out status for the API user?
  before_action :authorize_request, except: :create
  skip_before_action :verify_signed_out_user
  # This sets the default response format to json instead of html
  respond_to :json
  # POST /api/login
  #

  def new
    @user = current_user
    if @user
      render :'devise/sessions/new' , status: :ok
    else
      head(:unauthorized)
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render :show , status: :ok
    else
      head(:unauthorized)
    end
  end

  def create
    @user = User.where(email: params[:email]).first

    if @user&.valid_password?(params[:password])
      jwt = JWT.encode(
        { user_id: @user.id, exp: (Time.now + 2.weeks).to_i, email: @user.email },
        ENV["SECRET_KEY_BASE"],
        'HS256'
      )

      render :create, locals: { token: jwt }, status: :ok
    else
      render json: { errors: @user ? 'Password not valid' : 'Email not valid' }, status: :unauthorized
    end
  end

  def destroy
    current_user&.authentication_token = nil
    if current_user&.save
      head :ok
    else
      head :unauthorized
    end
  end
end