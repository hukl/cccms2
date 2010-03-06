class ApplicationController < ActionController::Base
  
  before_filter :set_locale
  
  
  def set_locale
    I18n.locale = params[:locale]
    self.url_options = { :locale => I18n.locale }
  end
  
  # def default_url_options(options=nil)
  #   { :locale => I18n.locale }
  # end
  
  protect_from_forgery
end
