# -*- encoding : utf-8 -*-
class TimeWork < ActiveRecord::Base
  include ModelBase

  has_soft_deletion default_scope: true

  attr_accessible :project_id, :user_id,
                  :description, :is_open,
                  :begin_at, :end_at, :deleted_at

  belongs_to :project
  belongs_to :user

  validates_presence_of :user_id, :begin_at
  validates_presence_of :end_at, if: :is_not_open?

  def self.has_any_time_work_on_open? user
    time_works = self.where(user_id: user, is_open: true)
    if time_works.size > 0
      return time_works[0]
    end

    return nil
  end

  def self.time_works_today(user_id, project_id = nil)
    query = String.new
    unless project_id.nil?
      query = "project_id = (#{project_id}) AND"
    end
    return self.where("#{query} user_id = #{user_id} AND to_char(begin_at, 'YYYY-MM-DD') = '#{Time.now.to_date}'")
  end

  def self.worked_today_project(project)
    time_works = time_works_today(project.user.id, project.id)
    resultado = format_time_hash(time_works)

    return resultado
  end

  def hours_worked
    time_works = [self]
    resultado = TimeWork.format_time_hash(time_works)

    return resultado
  end

  def self.worked_today user
    time_works = time_works_today(user.id)
    resultado = format_time_hash(time_works)

    return resultado
  end

  def self.format_time_hash(time_works)
    time_hash = calculate_time_hash(time_works)
    return "#{time_hash[:hours]}h #{time_hash[:minutes]}min"
  end

  def self.calculate_time_hash(time_works)
    seconds_total = 0

    time_works.each do |tw|
      if tw.end_at.nil?
        t1 = Time.now #date1
      else
        t1 = tw.end_at #date1
      end

      t2 = tw.begin_at

      seconds_total += (t1.to_i - t2.to_i)
    end

    time_hash = time_in_hash(seconds_total)
  end

  # Método que serve para atualizar o contador
  def timing
    t1 = Time.now
    t2 = self.begin_at
    seconds = (t1.to_i - t2.to_i)
    time_hash = TimeWork.time_in_hash(seconds)

    return "#{time_hash[:hours]}, #{time_hash[:minutes]}, #{time_hash[:seconds]}"
  end

  # Retorna quantos dias, horas, minutos e segundos passaram de acordo com o parm :seconds
  def self.time_in_hash(seconds)
    days = seconds / 86400;
    hours = seconds / 3600;
    minutes = (seconds - (hours * 3600)) / 60;
    seconds = (seconds - (hours * 3600) - (minutes * 60))

    time_hash = Hash.new
    time_hash[:days]    = days
    time_hash[:hours]   = hours
    time_hash[:minutes] = minutes
    time_hash[:seconds] = seconds

    return time_hash
  end

  def project_name
    return self.project.name unless self.project.nil?
    return ""
  end

  private

  def is_not_open?
    return !is_open
  end
end
