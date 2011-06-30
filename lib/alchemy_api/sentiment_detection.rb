module AlchemyApi
  SentimentResult = Struct.new(:sentiment, :score, :language)

  class SentimentDetection < Base
    post(:get_sentiment_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetTextSentiment"
      params :url => url,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::SentimentDetection.get_sentiment_handler(response)
      end
    end

    post(:get_sentiment_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetTextSentiment"
      params :html => html,
             :url => options[:url],
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::SentimentDetection.get_sentiment_handler(response)
      end
    end

    post(:get_sentiment_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetTextSentiment"
      params :text => text,
             :url => options[:url]
      handler do |response|
        AlchemyApi::SentimentDetection.get_sentiment_handler(response)
      end
    end

    def self.get_sentiment_handler(response)
      json = get_json(response)
      SentimentResult.new(json['docSentiment']['type'], json['docSentiment']['score'], json['language'])
    end
  end
end
