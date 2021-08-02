class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :organization_id
      t.string :line_1
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
