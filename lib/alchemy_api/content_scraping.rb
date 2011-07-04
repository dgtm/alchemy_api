module AlchemyApi
  ScrapingResult = Struct.new(:status, :results)

  class ContentScraping < Base
    post(:scrape_content_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetConstraintQuery"
      params :url => url,
             :cquery => options[:cquery]
      handler do |response|
        AlchemyApi::ContentScraping.get_content_handler(response)
      end
    end

    post(:scrape_content_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetConstraintQuery"
      params :html => html,
             :url => options[:url],
             :cquery => options[:cquery]
      handler do |response|
        AlchemyApi::ContentScraping.get_content_handler(response)
      end
    end

    def self.get_content_handler(response)
      json = get_json(response)
      ScrapingResult.new(json['status'], json['queryResults'])
    end
  end
end
