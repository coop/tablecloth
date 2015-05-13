# https://github.com/solnic/transproc/blob/e2fbc12a51c8dc4fcb38d43a581134fcbedf5afa/lib/transproc/coercions.rb

require "date"
require "time"
require "bigdecimal"
require "bigdecimal/util"

module Tablecloth
  # Coercion functions for common types
  #
  # @api public
  module Coercions
    extend Transproc::Functions

    TRUE_VALUES = [true, 1, "1", "on", "t", "true", "y", "yes"].freeze
    FALSE_VALUES = [false, 0, "0", "off", "f", "false", "n", "no"].freeze

    BOOLEAN_MAP = Hash[
      TRUE_VALUES.product([true]) + FALSE_VALUES.product([false])
    ].freeze

    # Coerce value into a string
    #
    # @example
    #   Transproc(:to_string)[1]
    #   # => "1"
    #
    # @param [Object] value The input value
    #
    # @return [String]
    #
    # @api public
    def to_string(value, _world)
      value.to_s
    end

    # Coerce value into a symbol
    #
    # @example
    #   Transproc(:to_symbol)["foo"]
    #   # => :foo
    #
    # @param [Object] value The input value
    #
    # @return [Symbol]
    #
    # @api public
    def to_symbol(value, _world)
      value.to_sym
    end

    # Coerce value into a integer
    #
    # @example
    #   Transproc(:to_integer)["1"]
    #   # => 1
    #
    # @param [Object] value The input value
    #
    # @return [Integer]
    #
    # @api public
    def to_integer(value, _world)
      value.to_i
    end

    # Coerce value into a float
    #
    # @example
    #   Transproc(:to_float)["1.2"]
    #   # => 1.2
    #
    # @param [Object] value The input value
    #
    # @return [Float]
    #
    # @api public
    def to_float(value, _world)
      value.to_f
    end

    # Coerce value into a decimal
    #
    # @example
    #   Transproc(:to_decimal)[1.2]
    #   # => #<BigDecimal:7fca32acea50,"0.12E1",18(36)>
    #
    # @param [Object] value The input value
    #
    # @return [Decimal]
    #
    # @api public
    def to_decimal(value, _world)
      value.to_d
    end

    # Coerce value into a boolean
    #
    # @example
    #   Transproc(:to_boolean)["true"]
    #   # => true
    #   Transproc(:to_boolean)["f"]
    #   # => false
    #
    # @param [Object] value The input value
    #
    # @return [TrueClass,FalseClass]
    #
    # @api public
    def to_boolean(value, _world)
      BOOLEAN_MAP.fetch(value)
    end

    # Coerce value into a date
    #
    # @example
    #   Transproc(:to_date)["2015-04-14"]
    #   # => #<Date: 2015-04-14 ((2457127j,0s,0n),+0s,2299161j)>
    #
    # @param [Object] value The input value
    #
    # @return [Date]
    #
    # @api public
    def to_date(value, _world)
      Date.parse(value)
    end

    # Coerce value into a time
    #
    # @example
    #   Transproc(:to_time)["2015-04-14 12:01:45"]
    #   # => 2015-04-14 12:01:45 +0200
    #
    # @param [Object] value The input value
    #
    # @return [Time]
    #
    # @api public
    def to_time(value, _world)
      Time.parse(value)
    end

    # Coerce value into a datetime
    #
    # @example
    #   Transproc(:to_datetime)["2015-04-14 12:01:45", nothing]
    #   # => #<DateTime: 2015-04-14T12:01:45+00:00 ((2457127j,43305s,0n),+0s,2299161j)>
    #
    # @param [Object] value The input value
    # @param [World] world Cucumber world object
    #
    # @return [DateTime]
    #
    # @api public
    def to_datetime(value, _world)
      DateTime.parse(value)
    end
  end
end
