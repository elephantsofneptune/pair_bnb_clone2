class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :address
      t.integer :pax
      t.boolean :availability, default: true

      t.belongs_to :user
      
      t.timestamps
    end
  end
end
