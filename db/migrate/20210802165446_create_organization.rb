class CreateOrganization < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :ein
      t.string :name

      t.timestamps
    end
  end
end
