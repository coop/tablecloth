require "tablecloth"

$registry = {}

require "money"

module CurrencyHelper
  def currency
    "AUD"
  end

  def money(amount_in_cents)
    Money.new(amount_in_cents, currency)
  end
end

World(CurrencyHelper)

  Transproc.register(:to_money) do |value, world|
    Money.new(value.gsub("$", "").to_i * 100, world.currency)
  end

def table(regex, &block)
  definition = Tablecloth::TableDefinition.new
  definition.instance_eval(&block)

  Transform(regex) do |table|
    table.map_headers!(definition.mapping)
    {regex: regex, table: table.hashes}
  end

  $registry[regex] = definition
end

def TableStep(regex, &block)
  When(regex) do |table|
    regex = table[:regex]
    value = table[:table]
    definition = $registry[regex]
    transformer = Tablecloth::Transformer.new(definition, self)

    instance_exec(transformer.call(value), &block)
  end
end

table(/^table:Transaction ID,Amount$/) do
  column :transaction_id, type: :integer, from: "Transaction ID"
  column :amount, type: :money, from: "Amount"
end

TableStep(/^we have a list of transactions like:$/) do |table|
  expected = [
    {transaction_id: 124, amount: money(50_00)},
    {transaction_id: 456, amount: money(100_00)},
  ]

  expect(table).to eq(expected)
end

Given(/^the world functions as expected$/) do
end

Then(/^something magical should happen$/) do
end

table(/^table:Order ID,Transaction ID,Amount$/) do
  column :order_id, type: :integer, from: "Order ID", retain_previous_value: true
  column :transaction_id, type: :integer, from: "Transaction ID"
  column :amount, type: :money, from: "Amount"
end

TableStep(/^we have a list of orders like:$/) do |table|
  expected = [
    {order_id: 1, transaction_id: 124, amount: money(50_00)},
    {order_id: 1, transaction_id: 456, amount: money(100_00)},
    {order_id: 2, transaction_id: 789, amount: money(75_00)},
  ]

  expect(table).to eq(expected)
end
