class AddColumnToAlbum < ActiveRecord::Migration[7.1]
  def change
    add_column :albums, :number_photos, :integer
  end
end
