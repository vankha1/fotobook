class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :image_url
      t.string :title
      t.string :description
      t.string :sharing_mode
      t.integer :number_like
      t.belongs_to :user
      t.belongs_to :album

      t.timestamps
    end
  end
end
