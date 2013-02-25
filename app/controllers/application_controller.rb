class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_up_fails_path_for(resource)
      redirect_to :back
  end

end
