class Users::OmniauthCallbacksController < ApplicationController

  def facebook
    # raise request.env["omniauth.auth"].to_yaml
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted? # retarna true si es q est guardado en la bd y false no esta
      @user.remember_me = true
      sign_in_and_redirect @user, event: :authentication
      return
    end
    session["devise.auth"] = request.env["omniauth.auth"]

    render :edit
  end

  def custom_sign_up
    @user = User.from_omniauth(session["devise.auth"])
    if @user.update(user_params)
      sign_in_and_redirect @user, event: :authentication
    else
      render :edit
    end

    # @user
  end

  def failure
    redirect_to new_user_session_path, notice: "No pudimos Loguearte Error: #{params[:error_description]}. Motivo #{params[:error_reason]}"
  end

  private
    def user_params
      # Parametros fuertes
      params.require(:user).permit(:name,:username,:email)
    end


end
