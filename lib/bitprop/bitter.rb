module Bitprop::Bitter
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def define_bit_attr(bit_attr_name, list_attr_name)
      Bitprop::ClassAndPropMap.instance.add_class_and_props(self, list_attr_name)
      list_attr_name.each_with_index do | attr_name, idx |

        define_method(attr_name) do
          0 < send(bit_attr_name) & (2 ** idx)
        end

        define_method("#{attr_name}=") do |bit|
          mask = (1 << (list_attr_name.size)) - 1
          mask -= 1 << idx
          send("#{bit_attr_name}=", send(bit_attr_name) & mask)
          if bit
            send("#{bit_attr_name}=", send("#{bit_attr_name}") + (1 << idx))
          end
          bit_attr_name
        end
      end
    end

    def bit_attr_names
      Bitprop::ClassAndPropMap.instance.get_props_by_class(self)
    end
  end

  def all_bit_attr_hash
    ret_hash = {}
    self.class.bit_attr_names.each do |meth|
      ret_hash[meth] = self.send(meth)
    end
    ret_hash
  end
end