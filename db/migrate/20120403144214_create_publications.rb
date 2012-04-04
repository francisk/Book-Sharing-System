class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :translator
      t.string :summary
      t.float :price
      t.integer :pages
      t.text :author_intro
      t.string :cover
      t.integer :state
      t.integer :contributor
      t.string :location

      t.timestamps
    end
  end
end
