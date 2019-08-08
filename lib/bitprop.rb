require "bitprop/version"
require "bitprop/bitter"
require "singleton"

module Bitprop
  class Error < StandardError; end
  class ClassAndPropMap
    include Singleton

    def initialize
      @class_and_props = {}
    end

    def add_class_and_props(klass, props)
      @class_and_props[klass] = props
    end

    def get_props_by_class(klass)
      @class_and_props[klass]
    end
  end
end
