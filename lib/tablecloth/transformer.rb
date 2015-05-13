require "transproc"

module Tablecloth
  class Transformer
    def initialize(definition, *args)
      @definition = definition
      @args = args
    end

    def call(value)
      previous_values = {}

      value.map do |row|
        row.each_with_object({}) do |(key, value), hash|
          column = @definition[key]
          previous_value = previous_values[key]
          result = if previous_value && value == ""
            previous_value
          else
            visit(column).call(value)
          end

          previous_values[key] = result if column.retain_previous_value?
          hash[key] = result
        end
      end
    end

    private

    def visit(column)
      Transproc(:"to_#{column.type}", *@args)
    end
  end
end
