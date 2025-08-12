class AddSeatingConfigurationToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :sections, :text
    add_column :events, :seats_per_section, :integer, default: 50
    
    # Set default seating for existing events
    reversible do |dir|
      dir.up do
        Event.update_all(
          sections: ['A', 'B', 'C'].to_yaml,
          seats_per_section: 50
        )
      end
    end
  end
end
