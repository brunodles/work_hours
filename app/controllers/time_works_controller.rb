# -*- encoding : utf-8 -*-
class TimeWorksController < ApplicationController

  def contador
    @link_name = "contador"
    @time_work  = TimeWork.new
    respond_to do |format|
      respond_msg
      format.html # contador.html.erb
      format.json { render json: {time_work: @time_work} }
    end
  end

  # GET /time_works
  # GET /time_works.json
  def index
    @link_name = "horas"
    @time_work  = TimeWork.new
    @time_works = TimeWork.all_by_user_session user_web

    respond_to do |format|
      respond_msg
      format.html # index.html.erb
      format.json { render json: {time_works: @time_works, time_work: @time_work} }
    end
  end

  # GET /time_works/1
  # GET /time_works/1.json
  def show
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
      redirect_with_format(format, @time_work.user_id)

      format.html # show.html.erb
      format.json { render json: @time_work }
    end
  end

  ## GET /time_works/new
  ## GET /time_works/new.json
  #def new
  #  @time_work = TimeWork.new
  #
  #  respond_to do |format|
  #    format.html # _new.html.erb
  #    format.json { render json: @time_work }
  #  end
  #end

  # GET /time_works/1/edit
  def edit
    @time_work = TimeWork.find(params[:id])

    respond_to do | format |
      redirect_with_format(format, @time_work.user_id)
      format.html
    end

  end

  # POST /time_works
  # POST /time_works.json
  def create
    respond_to do |format|
      @time_works = TimeWork.all_by_user_session user_web

      if TimeWork.has_any_time_work_on_open? user_web
        @time_work = TimeWork.new

        format.html { render action: :index }
        format.json { head :no_content }
      else
        @time_work  = TimeWork.new(params[:time_work])

        @time_work.user_id  = user_web.id
        @time_work.begin_at = Time.now
        puts "@time_work.begin_at : #{@time_work.begin_at }"

        if @time_work.save
          format.html { redirect_to action: 'contador'}
          format.json { render json: @time_work, status: :created, location: @time_work }
        else
          format.html { render action: :index }
          format.json { render json: @time_work.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def end_time
    @time_work = TimeWork.find(params[:time_work][:id])

    respond_to do |format|
      redirect_with_format(format, @time_work.user_id)

      if @time_work.update_attributes(description: params[:time_work][:description],
                                      is_open:     false,
                                      end_at:      Time.now
      )
        format.html { redirect_to action: 'contador' }
        format.json { head :no_content }
      else
        format.html { render time_works_path }
        format.json { render json: @time_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_works/1
  # PUT /time_works/1.json
  def update
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
      redirect_with_format(format, @time_work.user_id)

      if @time_work.update_attributes(params[:time_work])
        @@msg_success = 'Hora atualizada com sucesso'
        format.html { redirect_to action: :index }
        format.json { head :no_content }
      else
        format.html { render time_works_url }
        format.json { render json: @time_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_works/1
  # DELETE /time_works/1.json
  def destroy
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
      redirect_with_format(format, @time_work.user_id)

      @time_work.soft_delete

      @@msg_success = 'Hora removida com sucesso'
      format.html { redirect_to time_works_url }
      format.json { head :no_content }
    end
  end

  private

  def redirect_with_format(format, id)
    redirect(format, id, :time_works, :index)
  end
end
