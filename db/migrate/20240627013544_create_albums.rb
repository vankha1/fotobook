class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.boolean :is_private
      t.integer :number_like

      t.timestamps
    end
  end
end
