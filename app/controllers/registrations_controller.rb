class RegistrationsController < Devise::RegistrationsController

  before_action :one_user_registered?, only: [:new, :create]
  
  protected

  # For now, only allow one user to register per this guide:
  # https://github.com/plataformatec/devise/wiki/How-To:-Set-up-devise-as-a-single-user-system
  def one_user_registered?
    if User.count == 1
      if user_signed_in?
        redirect_to root_path
      else
        redirect_to new_user_session_path
      end
    end  
  end

end
