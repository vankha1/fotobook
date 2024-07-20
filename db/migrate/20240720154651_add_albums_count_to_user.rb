class AddAlbumsCountToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :albums_count, :integer
  end
end
