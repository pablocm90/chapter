class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if session[:referal_url]
      book_path(session[:referal_url])
    else
      root_path
    end
  end
end


