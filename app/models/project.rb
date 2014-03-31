# -*- encoding : utf-8 -*-
class Project < ActiveRecord::Base
  include ModelBase

  has_soft_deletion default_scope: true

  attr_accessible :user_id, :name, :deleted_at

  belongs_to :user
  has_many :time_works

  validates_presence_of :user_id, :name

  def self.projects_by_user user
    return Project.where(user_id: user).order(:name)
  end
end
