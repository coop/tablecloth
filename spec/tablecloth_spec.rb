require 'spec_helper'
require "money"
require "transproc"

module Tablecloth
  Transproc.register(:to_money) do |value, world|
    Money.new(value, world.currency)
  end

  describe TableDefinition do
    describe "#column_names" do
      it "it works" do
        expected_column_names = %i(transaction_id amount)

        definition = TableDefinition.new
        definition.column(:transaction_id, type: :integer)
        definition.column(:amount, type: :money)

        expect(definition.column_names).to eq(expected_column_names)
      end
    end

    describe "#mapping" do
      it "it also works" do
        expected = {"Transaction ID" => :transaction_id, "Amount" => :amount}

        definition = TableDefinition.new
        definition.column(:transaction_id, type: :integer, from: "Transaction ID")
        definition.column(:amount, type: :money, from: "Amount")

        expect(definition.mapping).to eq(expected)
      end
    end
  end


  describe Transformer do
    describe "#call" do
      let(:definition) do
        definition = TableDefinition.new
        definition.column(:order_id, type: :integer, retain_previous_value: true)
        definition.column(:transaction_id, type: :integer)
        definition.column(:amount, type: :money)
        definition
      end

      it "transforms values" do
        expected = [
          {transaction_id: 123, amount: Money.new(50_00, "AUD")},
          {transaction_id: 456, amount: Money.new(100_00, "AUD")},
        ]
        data = [
          {transaction_id: "123", amount: "5000"},
          {transaction_id: "456", amount: "10000"},
        ]
        transformer = Transformer.new(definition, world)

        result = transformer.call(data).each.map do |row|
          row.to_hash
        end

        expect(result).to eq(expected)
      end

      it "retain previous values" do
        expected = [
          {order_id: 1, transaction_id: 123, amount: Money.new(50_00, "AUD")},
          {order_id: 1, transaction_id: 456, amount: Money.new(100_00, "AUD")},
          {order_id: 2, transaction_id: 789, amount: Money.new(75_00, "AUD")},
        ]
        data = [
          {order_id: "1", transaction_id: "123", amount: "5000"},
          {order_id: "", transaction_id: "456", amount: "10000"},
          {order_id: "2", transaction_id: "789", amount: "7500"},
        ]
        transformer = Transformer.new(definition, world)

        result = transformer.call(data).each.map do |row|
          row.to_hash
        end

        expect(result).to eq(expected)
      end
    end
  end
end
