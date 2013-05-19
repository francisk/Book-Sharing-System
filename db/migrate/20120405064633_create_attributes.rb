# -*- encoding : utf-8 -*-
class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.string :value
      t.integer :publication_id

      t.timestamps
    end
  end
end
