# -*- encoding : utf-8 -*-
class AddStateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :state, :integer
  end
end
