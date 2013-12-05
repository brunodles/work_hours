# -*- encoding : utf-8 -*-
class TimeWorksController < ApplicationController
  # GET /time_works
  # GET /time_works.json
  def index
    @time_works = TimeWork.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @time_works }
    end
  end

  # GET /time_works/1
  # GET /time_works/1.json
  def show
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_work }
    end
  end

  # GET /time_works/new
  # GET /time_works/new.json
  def new
    @time_work = TimeWork.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_work }
    end
  end

  # GET /time_works/1/edit
  def edit
    @time_work = TimeWork.find(params[:id])
  end

  # POST /time_works
  # POST /time_works.json
  def create
    @time_work = TimeWork.new(params[:time_work])

    respond_to do |format|
      if @time_work.save
        format.html { redirect_to @time_work, notice: 'Time work was successfully created.' }
        format.json { render json: @time_work, status: :created, location: @time_work }
      else
        format.html { render action: "new" }
        format.json { render json: @time_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_works/1
  # PUT /time_works/1.json
  def update
    @time_work = TimeWork.find(params[:id])

    respond_to do |format|
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
    @time_work.soft_delete

    respond_to do |format|
      format.html { redirect_to time_works_url }
      format.json { head :no_content }
    end
  end
end
