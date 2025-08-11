# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create sample organizers
organizers_data = [
  {
    name: "Sarah Johnson",
    email: "sarah@techconferences.com",
    company_name: "Tech Conferences Inc",
    phone: "+1 (555) 123-4567",
    website: "https://techconferences.com",
    description: "Leading organizer of technology conferences and workshops across the US."
  },
  {
    name: "Michael Rodriguez",
    email: "mike@musicevents.com", 
    company_name: "Music Events Co",
    phone: "+1 (555) 987-6543",
    website: "https://musicevents.com",
    description: "Specializing in live music events, festivals, and concert production."
  },
  {
    name: "Emily Chen",
    email: "emily@artgallery.com",
    company_name: "Metropolitan Art Gallery",
    phone: "+1 (555) 456-7890",
    website: "https://metroartgallery.com",
    description: "Curating world-class art exhibitions and cultural events."
  },
  {
    name: "David Thompson",
    email: "david@sportsevents.com",
    company_name: "Elite Sports Events",
    phone: "+1 (555) 234-5678",
    website: "https://elitesportsevents.com",
    description: "Organizing professional sports events, marathons, and athletic competitions."
  },
  {
    name: "Lisa Wong",
    email: "lisa@foodfestivals.com",
    company_name: "Gourmet Food Festivals",
    phone: "+1 (555) 345-6789",
    website: "https://gourmetfoodfestivals.com",
    description: "Creating unforgettable culinary experiences and food festival events."
  },
  {
    name: "James Miller",
    email: "james@businesssummits.com",
    company_name: "Business Leadership Summits",
    phone: "+1 (555) 567-8901",
    website: "https://businessleadershipsummits.com",
    description: "Executive leadership conferences and business networking events."
  },
  {
    name: "Maria Garcia",
    email: "maria@healthwellness.com",
    company_name: "Wellness & Health Events",
    phone: "+1 (555) 678-9012",
    website: "https://wellnesshealthevents.com",
    description: "Promoting health and wellness through educational events and workshops."
  }
]

organizers_data.each do |data|
  Organizer.find_or_create_by!(email: data[:email]) do |organizer|
    organizer.assign_attributes(data)
  end
end

# Create 16 sample events
events_data = [
  {
    title: "Rails World Conference 2025",
    description: "The premier Ruby on Rails conference featuring the latest developments, best practices, and networking opportunities.",
    venue_name: "San Francisco Convention Center",
    venue_address: "747 Howard St, San Francisco, CA 94103",
    venue_lat: 37.7849,
    venue_lng: -122.4011,
    event_date: 2.months.from_now,
    doors_open_at: 2.months.from_now - 1.hour,
    ticket_price_cents: 49900, # $499
    max_capacity: 1500,
    tickets_sold_count: 342,
    category: "conference",
    status: "published",
    organizer_email: "sarah@techconferences.com"
  },
  {
    title: "Summer Music Festival",
    description: "Three days of amazing live music featuring indie, rock, and electronic artists from around the world.",
    venue_name: "Golden Gate Park",
    venue_address: "Golden Gate Park, San Francisco, CA",
    venue_lat: 37.7694,
    venue_lng: -122.4862,
    event_date: 3.months.from_now,
    doors_open_at: 3.months.from_now - 2.hours,
    ticket_price_cents: 15000, # $150
    max_capacity: 5000,
    tickets_sold_count: 2847,
    category: "festival",
    status: "published",
    organizer_email: "mike@musicevents.com"
  },
  {
    title: "Modern Art Exhibition Opening",
    description: "Exclusive opening night for our newest contemporary art exhibition featuring emerging artists.",
    venue_name: "Metropolitan Art Gallery",
    venue_address: "1234 Gallery Ave, San Francisco, CA 94110",
    venue_lat: 37.7599,
    venue_lng: -122.4148,
    event_date: 3.weeks.from_now,
    doors_open_at: 3.weeks.from_now - 30.minutes,
    ticket_price_cents: 2500, # $25
    max_capacity: 200,
    tickets_sold_count: 87,
    category: "exhibition",
    status: "published",
    organizer_email: "emily@artgallery.com"
  },
  {
    title: "JavaScript Workshop: Advanced React Patterns",
    description: "Hands-on workshop covering advanced React patterns, state management, and performance optimization.",
    venue_name: "TechHub Co-working Space",
    venue_address: "456 Tech St, San Francisco, CA 94107",
    venue_lat: 37.7749,
    venue_lng: -122.4194,
    event_date: 2.weeks.from_now,
    doors_open_at: 2.weeks.from_now - 30.minutes,
    ticket_price_cents: 12900, # $129
    max_capacity: 50,
    tickets_sold_count: 23,
    category: "workshop",
    status: "published",
    organizer_email: "sarah@techconferences.com"
  },
  {
    title: "Bay Area Marathon 2025",
    description: "Annual marathon through the beautiful streets of San Francisco with stunning bay views.",
    venue_name: "Marina Green",
    venue_address: "Marina Green, San Francisco, CA 94123",
    venue_lat: 37.8021,
    venue_lng: -122.4416,
    event_date: 4.months.from_now,
    doors_open_at: 4.months.from_now - 2.hours,
    ticket_price_cents: 8500, # $85
    max_capacity: 3000,
    tickets_sold_count: 1245,
    category: "other",
    status: "published",
    organizer_email: "david@sportsevents.com"
  },
  {
    title: "Wine & Dine Festival",
    description: "Gourmet food and wine tasting featuring local chefs and international cuisine.",
    venue_name: "Union Square",
    venue_address: "Union Square, San Francisco, CA 94108",
    venue_lat: 37.7880,
    venue_lng: -122.4075,
    event_date: 6.weeks.from_now,
    doors_open_at: 6.weeks.from_now - 1.hour,
    ticket_price_cents: 7500, # $75
    max_capacity: 800,
    tickets_sold_count: 456,
    category: "festival",
    status: "published",
    organizer_email: "lisa@foodfestivals.com"
  },
  {
    title: "Leadership Summit 2025",
    description: "Executive leadership conference with keynotes from Fortune 500 CEOs and industry leaders.",
    venue_name: "Marriott Marquis",
    venue_address: "780 Mission St, San Francisco, CA 94103",
    venue_lat: 37.7853,
    venue_lng: -122.4056,
    event_date: 10.weeks.from_now,
    doors_open_at: 10.weeks.from_now - 30.minutes,
    ticket_price_cents: 79900, # $799
    max_capacity: 500,
    tickets_sold_count: 187,
    category: "conference",
    status: "published",
    organizer_email: "james@businesssummits.com"
  },
  {
    title: "Wellness Workshop: Mindful Living",
    description: "Learn meditation, mindfulness techniques, and stress reduction strategies from certified instructors.",
    venue_name: "Zen Center San Francisco",
    venue_address: "300 Page St, San Francisco, CA 94102",
    venue_lat: 37.7722,
    venue_lng: -122.4312,
    event_date: 5.weeks.from_now,
    doors_open_at: 5.weeks.from_now - 15.minutes,
    ticket_price_cents: 4500, # $45
    max_capacity: 75,
    tickets_sold_count: 34,
    category: "workshop",
    status: "published",
    organizer_email: "maria@healthwellness.com"
  },
  {
    title: "AI & Machine Learning Conference",
    description: "Cutting-edge developments in artificial intelligence and machine learning technologies.",
    venue_name: "Moscone Center West",
    venue_address: "800 Howard St, San Francisco, CA 94103",
    venue_lat: 37.7840,
    venue_lng: -122.4018,
    event_date: 3.months.from_now + 1.week,
    doors_open_at: 3.months.from_now + 1.week - 1.hour,
    ticket_price_cents: 69900, # $699
    max_capacity: 2000,
    tickets_sold_count: 896,
    category: "conference",
    status: "published",
    organizer_email: "sarah@techconferences.com"
  },
  {
    title: "Jazz Under the Stars",
    description: "Evening of smooth jazz performances in an intimate outdoor setting with city skyline views.",
    venue_name: "Rooftop at Pier 15",
    venue_address: "Pier 15, San Francisco, CA 94111",
    venue_lat: 37.8029,
    venue_lng: -122.3972,
    event_date: 7.weeks.from_now,
    doors_open_at: 7.weeks.from_now - 45.minutes,
    ticket_price_cents: 5500, # $55
    max_capacity: 300,
    tickets_sold_count: 156,
    category: "concert",
    status: "published",
    organizer_email: "mike@musicevents.com"
  },
  {
    title: "Photography Exhibition: Urban Landscapes",
    description: "Contemporary photography exhibition showcasing urban architecture and street photography.",
    venue_name: "SFMOMA",
    venue_address: "151 3rd St, San Francisco, CA 94103",
    venue_lat: 37.7857,
    venue_lng: -122.4011,
    event_date: 4.weeks.from_now,
    doors_open_at: 4.weeks.from_now - 30.minutes,
    ticket_price_cents: 1800, # $18
    max_capacity: 400,
    tickets_sold_count: 123,
    category: "exhibition",
    status: "published",
    organizer_email: "emily@artgallery.com"
  },
  {
    title: "Startup Pitch Competition",
    description: "Early-stage startups compete for funding from top venture capital firms and angel investors.",
    venue_name: "WeWork South Market",
    venue_address: "535 Mission St, San Francisco, CA 94105",
    venue_lat: 37.7886,
    venue_lng: -122.3968,
    event_date: 8.weeks.from_now,
    doors_open_at: 8.weeks.from_now - 1.hour,
    ticket_price_cents: 3500, # $35
    max_capacity: 250,
    tickets_sold_count: 89,
    category: "conference",
    status: "published",
    organizer_email: "james@businesssummits.com"
  },
  {
    title: "Cycling Championship",
    description: "Professional cycling race through the challenging hills and scenic routes of San Francisco.",
    venue_name: "Crissy Field",
    venue_address: "Crissy Field, San Francisco, CA 94129",
    venue_lat: 37.8018,
    venue_lng: -122.4682,
    event_date: 5.months.from_now,
    doors_open_at: 5.months.from_now - 3.hours,
    ticket_price_cents: 2000, # $20 (viewing)
    max_capacity: 2500,
    tickets_sold_count: 567,
    category: "other",
    status: "published",
    organizer_email: "david@sportsevents.com"
  },
  {
    title: "Farm-to-Table Cooking Class",
    description: "Interactive cooking class featuring organic, locally-sourced ingredients and sustainable cooking methods.",
    venue_name: "Culinary Academy",
    venue_address: "625 Polk St, San Francisco, CA 94102",
    venue_lat: 37.7811,
    venue_lng: -122.4186,
    event_date: 9.weeks.from_now,
    doors_open_at: 9.weeks.from_now - 30.minutes,
    ticket_price_cents: 8900, # $89
    max_capacity: 24,
    tickets_sold_count: 16,
    category: "workshop",
    status: "published",
    organizer_email: "lisa@foodfestivals.com"
  },
  {
    title: "Mental Health Awareness Seminar",
    description: "Educational seminar on mental health awareness, coping strategies, and community resources.",
    venue_name: "UCSF Parnassus Campus",
    venue_address: "505 Parnassus Ave, San Francisco, CA 94143",
    venue_lat: 37.7635,
    venue_lng: -122.4583,
    event_date: 11.weeks.from_now,
    doors_open_at: 11.weeks.from_now - 20.minutes,
    ticket_price_cents: 0, # Free
    max_capacity: 150,
    tickets_sold_count: 67,
    category: "workshop",
    status: "published",
    organizer_email: "maria@healthwellness.com"
  },
  {
    title: "Electronic Music Festival",
    description: "Two-day electronic music festival featuring world-renowned DJs and electronic artists.",
    venue_name: "Outside Lands Site",
    venue_address: "Golden Gate Park Polo Field, San Francisco, CA",
    venue_lat: 37.7694,
    venue_lng: -122.4862,
    event_date: 6.months.from_now,
    doors_open_at: 6.months.from_now - 2.hours,
    ticket_price_cents: 18500, # $185
    max_capacity: 8000,
    tickets_sold_count: 3421,
    category: "festival",
    status: "published",
    organizer_email: "mike@musicevents.com"
  }
]

require 'open-uri'

# Cover image URLs for each event type
cover_images = {
  "Rails World Conference 2025" => "https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=800&h=600&fit=crop",
  "Summer Music Festival" => "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop",
  "Modern Art Exhibition Opening" => "https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=800&h=600&fit=crop",
  "JavaScript Workshop: Advanced React Patterns" => "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=600&fit=crop",
  "Bay Area Marathon 2025" => "https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?w=800&h=600&fit=crop",
  "Wine & Dine Festival" => "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800&h=600&fit=crop",
  "Leadership Summit 2025" => "https://images.unsplash.com/photo-1573164713714-d95e436ab8d6?w=800&h=600&fit=crop",
  "Wellness Workshop: Mindful Living" => "https://images.unsplash.com/photo-1545389336-cf090694435e?w=800&h=600&fit=crop",
  "AI & Machine Learning Conference" => "https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=600&fit=crop",
  "Jazz Under the Stars" => "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop",
  "Photography Exhibition: Urban Landscapes" => "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop",
  "Startup Pitch Competition" => "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=800&h=600&fit=crop",
  "Cycling Championship" => "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&h=600&fit=crop",
  "Farm-to-Table Cooking Class" => "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=600&fit=crop",
  "Mental Health Awareness Seminar" => "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=800&h=600&fit=crop",
  "Electronic Music Festival" => "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=800&h=600&fit=crop"
}

events_data.each do |data|
  organizer = Organizer.find_by(email: data.delete(:organizer_email))
  event = Event.find_or_create_by!(title: data[:title], organizer: organizer) do |event|
    event.assign_attributes(data.merge(organizer: organizer))
  end
  
  # Attach cover image if not already attached
  if !event.cover.attached? && cover_images[event.title]
    begin
      image_url = cover_images[event.title]
      image_file = URI.open(image_url)
      filename = "#{event.title.parameterize}.jpg"
      event.cover.attach(io: image_file, filename: filename, content_type: 'image/jpeg')
      puts "Attached cover image for: #{event.title}"
    rescue => e
      puts "Failed to attach image for #{event.title}: #{e.message}"
    end
  end
end

puts "Created #{Organizer.count} organizers and #{Event.count} events with cover images"
