class AddLukittuToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lukittu, :boolean
  end
end
