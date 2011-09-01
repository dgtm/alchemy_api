module AlchemyApi
  class Base < MonsterMash::Base
    defaults do
      cache_timeout 999999
      user_agent 'Ruby AlchemyApi'
      params :apikey => AlchemyApi.api_key,
             :outputMode => 'json'
    end

    def self.get_json(response)
      json = JSON.parse(response.body)
      check_json_for_errors_and_raise!(json)
      json
    end

    def self.check_json_for_errors_and_raise!(json)
      if json['status'] == 'ERROR'
        case json['statusInfo']
        when 'invalid-api-key'
          raise InvalidApiKeyError, "The API key you sent (#{AlchemyApi.api_key.inspect}) is invalid! Please set AlchemyApi.api_key!"
        when 'cannot-retrieve'
          raise CannotRetrieveUrlError, "The URL (#{json['url']}) could not be retrieved."
        when 'cannot-retrieve:http-redirect-limit'
          raise RedirectionLimitError, "The URL (#{json['url']}) could not be retrieved, as it reached a redirect limit."
        when 'page-is-not-html'
          raise PageIsNotValidHtmlError, "The page at #{json['url']} is not valid HTML!"
        when 'content-exceeds-size-limit'
          raise ContentExceedsMaxLimitError, "The page at #{json['url']} is larger than 600KB!"
        when 'invalid-html'
          raise InvalidHtmlError, "The HTML sent was invalid!"
        when 'content-is-empty'
          raise ContentIsEmptyError, "The content you provided was empty!"
        when 'cannot-retrieve:operation-timeout:cannot-resolve-dns'
          raise URLError, "Cannot locate URL"
        when 'cannot-retrieve:downstream-http-error:404'
          raise URLError, "Cannot locate URL"
        else
          # raise UnknownError, "Got an unknown error: #{json['statusInfo']}"
        end
      end
    end
  end
end
