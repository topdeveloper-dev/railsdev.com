class ApplicationController < ActionController::Base
  include Locales
  include Pundit
  include StoredLocation

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :set_locale
  helper_method :resolve_locale

  def after_sign_in_path_for(user)
    if (stored_location = stored_location_for(:user)).present?
      stored_location
    elsif user.developer.present? || user.business.present?
      super
    else
      new_role_path
    end
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t("pundit.errors.unauthorized")
    redirect_back_or_to root_path, allow_other_host: false
  rescue ActionController::Redirecting::UnsafeRedirectError
    redirect_to root_path
  end
end
