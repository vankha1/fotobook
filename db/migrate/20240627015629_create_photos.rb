class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.string :image_url
      t.string :title
      t.string :description
      t.boolean :is_private
      t.integer :number_like
      t.belongs_to :user, foreign_key: true
      t.belongs_to :album, foreign_key: true

      t.timestamps
    end
  end
end
