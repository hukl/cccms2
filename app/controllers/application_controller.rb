class ApplicationController < ActionController::Base
  
  before_filter :set_locale
  
  def set_locale
    I18n.locale = params[:locale]
  end
  
  def default_url_options
    {:locale => I18n.locale}
  end
  
  protect_from_forgery
end
