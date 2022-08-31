require "seeds_helper"

def seed(file)
  load Rails.root.join("db", "seeds", "#{file}.rb")
  puts "Seeded #{file}"
end

# Disable letter_opener opening emails in the browser.
ActiveJob::Base.queue_adapter = :inline
ActionMailer::Base.delivery_method = :test

puts "Seeding #{Rails.env} database..."
seed "admins"
seed "developers"
seed "businesses"
seed "conversations"
seed "hiring"
puts "Seeded database"
