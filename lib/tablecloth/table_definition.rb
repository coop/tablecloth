module Tablecloth
  class TableDefinition
    Column = Struct.new(:name, :type, :from, :retain_previous_value) do
      def retain_previous_value?
        retain_previous_value
      end
    end
    UnknownColumn = Class.new(StandardError)

    def initialize
      @columns = {}
    end

    def column(name, type:, from: name, retain_previous_value: false)
      @columns[name] = Column.new(name, type, from, retain_previous_value)
    end

    def column_names
      @columns.map(&:first)
    end

    def mapping
      @columns.each_with_object({}) do |(name, column), hash|
        hash[column.from] = name
      end
    end

    def [](name)
      @columns.fetch(name) { raise(UnknownColumn, name) }
    end
  end
end
