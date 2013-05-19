# -*- encoding : utf-8 -*-
class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :publication_id
      t.integer :reader_id
      t.date :auditDate
      t.date :revertDate

      t.timestamps
    end
  end
end
