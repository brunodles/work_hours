# -*- encoding : utf-8 -*-
class LoginsController < ApplicationController

  skip_before_filter :verify_login

  def index
    @user = User.new

    respond_to do | format |
      respond_msg
      redirect_to_root format if user_logged_in?
      format.html
    end

  end

  def sign_in
    @user = User.new(params[:user])

    respond_to do | format |

      if @user.verify_inputs_to_login
        format.html { render action: 'index' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        user = User.user_by_login_and_password(@user)
         if user
           user.last_access_ip = request.remote_ip

           set_user_web user.update_attributes_to_login

           format.html { redirect_to controller: 'time_works', action: 'contador'}
         else
           @user.errors.add(:login, 'Login/Senha incorretos.')
           format.html { render action: 'index'}
           format.json { render json: @user.errors, status: :unprocessable_entity }
         end
      end

    end
  end

  def logout
    set_user_web nil

    redirect_to action: 'index'
  end
end
