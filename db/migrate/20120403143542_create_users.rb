# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :itcode
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
      
    end
  end
end
