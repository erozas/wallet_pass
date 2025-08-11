namespace :friendly_id do
  desc "Generate slugs for existing events"
  task generate_slugs: :environment do
    Event.find_each(&:save)
    puts "Generated slugs for #{Event.count} events"
  end
end