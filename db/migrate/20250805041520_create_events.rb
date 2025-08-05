class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :organizer, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :venue_name
      t.string :venue_address
      t.decimal :venue_lat, precision: 10, scale: 6
      t.decimal :venue_lng, precision: 10, scale: 6
      t.datetime :event_date
      t.datetime :doors_open_at
      t.integer :ticket_price_cents
      t.integer :max_capacity
      t.integer :tickets_sold_count, default: 0
      t.string :category, default: 'active'
      t.string :status

      t.timestamps
    end

    add_index :events, :event_date
    add_index :events, :status
    add_index :events, [:venue_lat, :venue_lng]
  end
end
