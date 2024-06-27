class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.string :sharing_mode
      t.integer :number_like

      t.timestamps
    end
  end
end
