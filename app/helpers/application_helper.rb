# -*- encoding : utf-8 -*-
module ApplicationHelper

  def user_web
    return session[:user_web]
  end
end
