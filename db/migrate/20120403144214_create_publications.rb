# -*- encoding : utf-8 -*-
class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :summary
      t.string :cover
      t.string :doubanURL
      t.integer :state
      t.integer :contributor_id
      t.string :location

      t.timestamps
    end
  end
end
