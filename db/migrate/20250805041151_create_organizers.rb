class CreateOrganizers < ActiveRecord::Migration[8.0]
  def change
    create_table :organizers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :company_name, null: false
      t.string :phone
      t.text :description
      t.string :website

      t.timestamps
    end
    add_index :organizers, :email, unique: true
  end
end
