# Tablecloth

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/tablecloth`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tablecloth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tablecloth

## Usage

``` cucumber
Scenario: Something interesting involing a table transformation
  Given the world functions as expected
  When we have a list of orders like:
    | Order ID | Transaction ID | Amount |
    | 1        | 124            | $50    |
    |          | 456            | $100   |
    | 2        | 789            | $75    |
  Then something magical should happen
```

``` ruby
# register transformations
Transproc.register(:to_money) do |value, world|
  Money.new(value.gsub("$", "").to_i * 100, world.currency)
end

table(/^table:Order ID,Transaction ID,Amount$/) do
  column :order_id, type: :integer, from: "Order ID", retain_previous_value: true
  column :transaction_id, type: :integer, from: "Transaction ID"
  column :amount, type: :money, from: "Amount"
end

TableStep(/we have a list of orders like:/) do |table|
  table # => [
        #      {order_id: 1, transaction_id: 124, amount: money(50_00)},
        #      {order_id: 1, transaction_id: 456, amount: money(100_00)},
        #      {order_id: 2, transaction_id: 789, amount: money(75_00)},
        #    ]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/coop/tablecloth/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
