# -*- encoding : utf-8 -*-
class ChangeColumnsToTimeWorks < ActiveRecord::Migration
  def up
    change_column :time_works, :begin_at, 'timestamp with time zone'
    change_column :time_works, :end_at, 'timestamp with time zone'
  end

  def down
    change_column :time_works, :begin_at, :datetime
    change_column :time_works, :end_at, :datetime
  end
end
