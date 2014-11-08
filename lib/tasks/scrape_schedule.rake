task :scrape_schedule => :environment do
  ApplicationController.helpers.scrape_schedule
end
