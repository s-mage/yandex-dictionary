require_relative 'yandex_dictionary/version'
require 'httparty'

module Yandex::Dictionary
  include HTTParty
  base_uri 'https://dictionary.yandex.net/api/v1/dicservice.json/'

  attr_accessor :api_key

  class TranslationError < StandardError; end
  class ApiError < StandardError; end

  # List of translation directions.
  def get_langs
    visit '/getLangs', key: api_key
  end

  # Search word or phrase. Return dictionary entry.
  def lookup(text, *lang)
    options = { key: api_key, text: text, lang: lang.join('-') }
    visit('/lookup', options)
  end

  def visit(address, options = {})
    responce = get(address, query: options)
    check_errors(responce) unless responce.code == 200
    responce
  end

  def check_errors(responce)
    raise *(case responce.code
    when 401 then [ApiError, 'Invalid api key']
    when 402 then [ApiError, 'Api key blocked']
    when 403 then [ApiError, 'Daily request limit exceeded']
    when 404 then [ApiError, 'Daily char limit exceeded']
    when 413 then [TranslationError, 'Text too long']
    when 501 then [TranslationError, 'Can\'t translate text in that direction']
    end)
  end

  extend Yandex::Dictionary
end
