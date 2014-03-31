# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_login

  @@msg_success = String.new
  @@msg_error   = String.new

  def respond_msg
    # Limpa as variáveis de método
    @msg_success = String.new
    @msg_error   = String.new
    # Popula as msgs
    @msg_success = @@msg_success unless @@msg_success.empty?
    @msg_error   = @@msg_error unless @@msg_error.empty?
    # Limpa as variáveis de classe
    @@msg_success = String.new
    @@msg_error   = String.new
  end

  def user_web
    return session[:user_web]
  end

  def set_user_web(user)
    session[:user_web] = user
  end

  def id_belongs_user_web? (id)
    return id.to_i == user_web.id
  end

  def user_logged_in?
    return !user_web.nil?
  end

  private

  def redirect_to_root(format)
    rendirect_with_format_html(format, :time_works, :contador)
  end

  # Método que redireciona para o controller/action caso o :id seja diferente do id do user_web
  def redirect(format, id, controller, action)
    unless id_belongs_user_web? id
      rendirect_with_format_html(format, controller, action)
    end
  end

  def rendirect_with_format_html(format, controller, action)
    format.html { redirect_to controller: controller, action: action }
  end

  def verify_login
    redirect_to controller: 'logins', action: 'index' if user_web.nil?
  end
end
