class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # kaikki kontrollerit jotka perivät ApplicationControllerin saavat metodit käyttöönsä
  # ApplicationControllerin alle määritetään myös apumetodit
  # määritetään, että metodi current_user tulee käyttöön myös näkymissä  
  helper_method :current_user # helper metodit määrittää metodin kaikkien näkymien käyttöön
  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to singin_path, notice:'you should be signed in' if current_user.nil?
  end

end