module AlchemyApi
  EntityResult = Struct.new(:entities)

  class EntityDetection < Base
    post(:get_entity_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetRankedNamedEntities"
      params :url => url,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath],
             :maxRetrieve => options[:limit]
      handler do |response|
        AlchemyApi::EntityDetection.get_entity_handler(response)
      end
    end

    post(:get_entity_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetRankedNamedEntities"
      params :html => html,
             :url => options[:url],
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :maxRetrieve => options[:limit],
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::EntityDetection.get_entity_handler(response)
      end
    end

    post(:get_entity_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetRankedNamedEntities"
      params :text => text,
             :maxRetrieve => options[:limit],
             :url => options[:url]
      handler do |response|
        AlchemyApi::EntityDetection.get_entity_handler(response)
      end
    end

    def self.get_entity_handler(response)
      json = get_json(response)
      EntityResult.new(json['entities'])
    end
  end
end