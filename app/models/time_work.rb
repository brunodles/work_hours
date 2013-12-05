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

  private

  def is_not_open?
    return !is_open
  end
end
