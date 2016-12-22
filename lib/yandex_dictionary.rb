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
    langs
  end

  def langs
    visit('/getLangs').to_a
  end

  # Search word or phrase. Return dictionary entry.
  def lookup(text, from_lang, to_lang, params = {})
    options = { text: text, lang: [from_lang, to_lang].join('-') }
    options[:flags] = determine_flags(params[:flags]) if params.key?(:flags)
    options[:ui] = params[:ui] if params.key?(:ui)
    visit('/lookup', options)['def']
  end

  protected

  def determine_flags(flags)
    flag = 0
    flag += 1 if flags.include?(:family)
    flag += 4 if flags.include?(:morpho)
    flag += 8 if flags.include?(:pos)
    flag
  end

  def visit(address, options = {})
    responce = get address, query: options.merge(key: api_key)
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
