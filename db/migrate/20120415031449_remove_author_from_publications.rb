class RemoveAuthorFromPublications < ActiveRecord::Migration
  def up
    remove_column :publications, :author
      end

  def down
    add_column :publications, :author, :string
  end
end
