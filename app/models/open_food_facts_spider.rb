class OpenFoodFactsSpider < Kimurai::Base
  @name = 'open_food_facts_spider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//ul[@class='products']//li/a").each do |a|
      relative_url = a[:href]
      request_to :parse_product_page, url: absolute_url(relative_url, base: url)
      break
    end
  end

  def parse_product_page(response, url:, data: {})
    item = build_item(response, url)
    product = Product.find_or_initialize_by(code: item[:code])
    product.attributes = item
    product.save
    puts product.errors.messages if product.errors.present?
  end

  private

  def build_item(response, url)
    item = {}
    item[:code] = response.xpath("//span[@id='barcode']").text
    item[:barcode] = response.xpath("//p[@id='barcode_paragraph']").text.strip.remove('Barcode:  ')
    item[:url] = url
    item[:product_name] = response.xpath("//h1[@class='title-3']").text.strip
    item[:quantity] = response.xpath("//span[@id='field_quantity_value']").text
    item[:categories] = response.xpath("//span[@id='field_categories_value']").text
    item[:packaging] = response.xpath("//span[@id='field_packaging_value']").text
    item[:brands] = response.xpath("//span[@id='field_brands_value']").text
    item[:image_url] = response.xpath("//img[@class='product_image']").map { |img| p img.attr('src') }.first
    item[:imported_t] = Time.now.utc.to_formatted_s(:number)
    item[:status] = 'imported'
    item
  end
end
