require 'spec_helper'

describe Yandex::Dictionary do
  let(:api_key) { 'secret' }

  before(:each) { Yandex::Dictionary.api_key = api_key }

  let(:base_url) do
    'https://dictionary.yandex.net/api/v1/dicservice.json'
  end
  let(:request_url) { "#{base_url}/#{request_action}?#{request_body}" }
  let(:response_body) { '{}' }

  before(:each) do
    stub_request(:get, request_url).to_return(
      body: response_body,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  describe '#langs' do
    let(:request_action) { 'getLangs' }

    describe 'sends the correct api key and parameters' do
      let(:request_body) { "key=#{api_key}" }

      it do
        Yandex::Dictionary.langs
      end
    end
  end

  describe '#lookup' do
    let(:request_action) { 'lookup' }

    describe 'sends the correct api key and parameters' do
      let(:request_body) { "key=#{api_key}&lang=en-ru&text=Car" }

      it do
        Yandex::Dictionary.lookup('Car', 'en', 'ru')
      end
    end

    describe 'sends the correct flags if specified' do
      describe 'morpho' do
        let(:request_body) { "flags=4&key=#{api_key}&lang=en-ru&text=Car" }

        it do
          Yandex::Dictionary.lookup('Car', 'en', 'ru', flags: %i(morpho))
        end
      end

      describe 'morpho and family' do
        let(:request_body) { "flags=5&key=#{api_key}&lang=en-ru&text=Car" }

        it do
          Yandex::Dictionary.lookup('Car', 'en', 'ru', flags: %i(morpho family))
        end
      end
    end

    describe 'sends the ui language if specified' do
      let(:request_body) { "key=#{api_key}&lang=en-ru&text=Car&ui=ru" }

      it do
        Yandex::Dictionary.lookup('Car', 'en', 'ru', ui: 'ru')
      end
    end
  end
end
