# -*- encoding : utf-8 -*-
class UsersController < ApplicationController

  layout 'logins', only: [:new, :create]
  skip_before_filter :verify_login, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    #@users = User.all

    respond_to do |format|
      format.html {redirect_to controller: :time_works, action: :contador}
      #format.html # index.html.erb
      #format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user = User.find(params[:id])

    respond_to do |format|
      format.html {redirect_to controller: :time_works, action: :contador}
      #format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      redirect_to_root format if user_logged_in?

      format.html # _new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @link_name = "usuario"
    @user = User.find(params[:id])

    respond_to do | format |
      unless id_belongs_user_web? @user.id
        @@msg_error = 'Você não tem permissão'
      end
      redirect_with_format(format, @user.id)
      format.html
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.password and !@user.password.empty?
        # seta a senha para Md5 caso a senha seja direfente de nulo
        @user.password              =  User.generate_md5(@user.password)
        @user.password_confirmation =  User.generate_md5(@user.password_confirmation)
      end

      if @user.save
        @@msg_success = 'Bem vindo ao WorkedHours'

        @user.last_access_ip = request.remote_ip

        set_user_web @user.update_attributes_to_login

        format.html { redirect_to controller: 'time_works', action: 'contador'}

        #format.html { redirect_to controller: :logins, action: :index}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      redirect_with_format(format, @user.id)

      # pega o users do formulário
      user = User.new(params[:user])

      if user.password and !user.password.empty?
        # seta a senha para Md5 caso a senha seja direfente de nulo
        user.password              =  User.generate_md5(user.password)
        user.password_confirmation =  User.generate_md5(user.password_confirmation)
      else
        user.password = @user.password
        user.password_confirmation = @user.password
      end

      #seta os campos para dar o update no @users existente
      if @user.update_attributes(:password => user.password,
                                 :password_confirmation => user.password_confirmation,
                                 :name => user.name,
                                 :email => user.email)

        set_user_web User.find(@user.id)

        @@msg_success = 'Perfil atualizado com sucesso'
        format.html { redirect_to controller: :time_works ,action: :contador}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #@user = User.find(params[:id])
    #@user.soft_delete
    #
    #respond_to do |format|
    #  format.html { redirect_to users_url }
    #  format.json { head :no_content }
    #end
  end

  private

  def redirect_with_format(format, id)
    redirect(format, id, :time_works, :contador)
  end
end
