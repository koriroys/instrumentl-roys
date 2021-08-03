class CreateFilings < ActiveRecord::Migration[6.1]
  def change
    create_table :filings do |t|
      t.integer :organization_id

      t.timestamps
    end
  end
end
