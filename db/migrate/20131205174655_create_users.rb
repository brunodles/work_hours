# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :password
      t.string :email
      t.integer :access_number, default: 0
      t.datetime :last_access_at
      t.string :last_access_ip
      t.string :password_recovery_hash
      t.datetime :password_recovery_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
