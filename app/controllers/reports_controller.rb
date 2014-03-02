# -*- encoding : utf-8 -*-
class ReportsController < ApplicationController

  def index
    @link_name = "relatorios"
    @projects_ids = params[:projects_ids]
    @projects     = Array.new
    if @projects_ids.nil?
      @projects_ids = Array.new
    else
      @projects_ids.each do |id|
        @projects << Project.find(id)
      end
    end
  end
end
