yandex-dictionary
=================

Library for Yandex Dictionary API | Библиотека для API Яндекс.Словарей

[![Code Climate](https://codeclimate.com/repos/52d659986956802fe200296b/badges/c88b32d9e26d7ee0e66f/gpa.png)](https://codeclimate.com/repos/52d659986956802fe200296b/feed)

## Installation

Add this line to your application's Gemfile:

    gem 'yandex-dictionary'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yandex-dictionary

## Usage

Require gem:

```ruby
  require 'yandex_dictionary'
```

Get api key [there](http://api.yandex.ru/key/form.xml?service=dict).

Set your api key:

```ruby
  Yandex::Dictionary.api_key = 'your.key'
```

To get list of directions use get_langs:

```ruby
  Yandex::Dictionary.get_langs
```
To get dictionary entry about word(in json) use lookup method:

```ruby
  Yandex::Dictionary.lookup 'Amnesty', 'en', 'en'
```

Optional parameters can be specified such:

```ruby
  Yandex::Dictionary.lookup 'Amnesty', 'en', 'en', flags: %(family morpho), ui: 'ru'
```

(for more details see the [official method definition](https://tech.yandex.com/dictionary/doc/dg/reference/lookup-docpage/))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
