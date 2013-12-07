# -*- encoding : utf-8 -*-
class TimeWorksController < ApplicationController
  # GET /time_works
  # GET /time_works.json
  def index
    @time_work  = TimeWork.new
    @time_works = TimeWork.all_by_user_session user_web

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {time_works: @time_works, time_work: @time_work} }
    end
  end

  # GET /time_works/1
  # GET /time_works/1.json
  def show
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
      redirect_index_with_format(format, @time_work.user_id)

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
      redirect_index_with_format(format, @time_work.user_id)
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

        if @time_work.save
          format.html { redirect_to time_works_path, notice: 'Time work was successfully created.' }
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
      redirect_index_with_format(format, @time_work.user_id)
      puts "passou"
      if @time_work.update_attributes(description: params[:time_work][:description],
                                      is_open:     false,
                                      end_at:      Time.now
      )
        format.html { redirect_to time_works_path, notice: 'Time work was successfully updated.' }
        format.json { head :no_content }
      else
        puts "entrou else"
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
      redirect_index_with_format(format, @time_work.user_id)

      if @time_work.update_attributes(params[:time_work])
        format.html { redirect_to @time_work, notice: 'Time work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_works/1
  # DELETE /time_works/1.json
  def destroy
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
      redirect_index_with_format(format, @time_work.user_id)

      @time_work.soft_delete

      format.html { redirect_to time_works_url, notice: 'Time work was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def redirect_index_with_format(format, id)
    unless id_belongs_user_web? id
      format.html { redirect_to controller: :time_works, action: :index }
    end
  end
end
