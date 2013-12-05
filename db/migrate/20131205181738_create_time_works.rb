# -*- encoding : utf-8 -*-
class CreateTimeWorks < ActiveRecord::Migration
  def change
    create_table :time_works do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :description
      t.boolean :is_open, default: true
      t.datetime :begin_at
      t.datetime :end_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :time_works, :user_id
    add_index :time_works, :project_id
  end
end
