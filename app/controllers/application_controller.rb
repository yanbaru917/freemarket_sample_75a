class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end
  
  def production?
    Rails.env.production?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
  

  # def after_sign_in_path_for(resource)
  #   mypage_root_path 
  # end


  # def after_sign_out_path_for(resource_or_scope)
  #   if resource_or_scope == :user
  #     destroy_user_session_path
  #   else
  #     root_path
  #   end
  # end
end
