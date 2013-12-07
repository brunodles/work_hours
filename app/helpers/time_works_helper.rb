# -*- encoding : utf-8 -*-
module TimeWorksHelper

  def raw_correct_form
    time_work = TimeWork.has_any_time_work_on_open? user_web

    if time_work
      @time_work = time_work
      raw render 'time_works/end_form'
    else
      raw render 'time_works/new'
    end
  end
end
