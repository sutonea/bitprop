require_relative '../lib/bitprop/bitter'

RSpec.describe Bitprop do
  it "has a version number" do
    expect(Bitprop::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(true).to eq(true)
  end

  class ExtendedClass
    include Bitprop::Bitter
    define_bit_attr :access_control, [:readable, :writable, :executable]
    def initialize(access_control)
      @access_control = access_control
    end

    def access_control
      3
    end
  end

  let(:target_object) { ExtendedClass.new(6) }
  it "can extend class" do
    expect(target_object.readable).to be_truthy
    expect(target_object.writable).to be_truthy
    expect(target_object.executable).to be_falsey
  end

  it "can get attributes as hash" do
    expect(target_object.all_bit_attr_hash).to eq(readable: true, writable: true, executable: false)
  end
end
