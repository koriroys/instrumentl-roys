class CreateAward < ActiveRecord::Migration[6.1]
  def change
    create_table :awards do |t|
      t.integer :filing_id
      t.integer :recipient_id
      t.string :amount
      t.string :purpose

      t.timestamps
    end
  end
end
