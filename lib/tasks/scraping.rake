namespace :scraping do
  desc "Task for scraping https://world.openfoodfacts.org/ page"
  task open_food_facts: :environment do
    url = 'https://world.openfoodfacts.org/'
    OpenFoodFactsSpider.process(url)
  end
end
