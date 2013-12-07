# -*- encoding : utf-8 -*-
class TimeWork < ActiveRecord::Base
  has_soft_deletion default_scope: true

  attr_accessible :project_id, :user_id,
                  :description, :is_open,
                  :begin_at, :end_at, :deleted_at

  belongs_to :project
  belongs_to :user

  validates_presence_of :user_id, :begin_at
  validates_presence_of :end_at, if: :is_not_open?

  def self.all_by_user_session user
    return self.where(user_id: user).order('created_at DESC')
  end

  def self.has_any_time_work_on_open? user
    time_works = self.where(user_id: user, is_open: true)
    if time_works.size > 0
      return time_works[0]
    end

    return nil
  end

  private

  def is_not_open?
    return !is_open
  end
end
