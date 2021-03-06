# Lccnorm

[![Gem Version](http://img.shields.io/gem/v/lccnorm.svg)][gem]
[![Build Status](http://img.shields.io/travis/seanredmond/lccnorm-rb.svg)][travis]

[gem]: https://rubygems.org/gems/lccnorm
[travis]: http://travis-ci.org/seanredmond/lccnorm-rb

Normalize and validate Library of Congress Control Numbers according to [LOC
guidelines](https://www.loc.gov/marc/lccn-namespace.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lccnorm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lccnorm

## Usage

Get a normalized version of an LCCN:

    > Lccnorm::normalize("75-425165//r75")
     => "75425165"
     
Check that an LCCN is valid:

    > Lccnorm::valid?("75425165")
     => true
    > Lccnorm::valid?("not even a number")
     => false

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/seanredmond/lccnorm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lccnorm project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/seanredmond/lccnorm/blob/master/CODE_OF_CONDUCT.md).
