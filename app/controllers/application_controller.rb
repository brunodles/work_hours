# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_login

  def user_web
    return session[:user_web]
  end

  def set_user_web(user)
    session[:user_web] = user
  end

  def id_belongs_user_web? (id)
    return id.to_i == user_web.id
  end

  private

  # Método que redireciona para o controller/action caso o :id seja diferente do id do user_web
  def redirect(format, id, controller, action)
    unless id_belongs_user_web? id
      format.html { redirect_to controller: controller, action: action }
    end
  end

  def verify_login
    redirect_to controller: 'login', action: 'index' if user_web.nil?
  end
end
