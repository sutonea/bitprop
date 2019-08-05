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
    attr_accessor :my_bits
    define_bit_attr :my_bits, [:first, :second, :third]
  end

  let(:target_object) { ExtendedClass.new }

  it "can read" do
    target_object.my_bits = 0b001
    expect(target_object.first).to  be_truthy
    expect(target_object.second).to be_falsey
    expect(target_object.third).to  be_falsey

    target_object.my_bits = 0b100
    expect(target_object.first).to  be_falsey
    expect(target_object.second).to be_falsey
    expect(target_object.third).to  be_truthy

    target_object.my_bits = 0b010
    expect(target_object.first).to  be_falsey
    expect(target_object.second).to be_truthy
    expect(target_object.third).to  be_falsey
  end

  it "can read as hash" do
    target_object.my_bits = 0b001
    expect(target_object.all_bit_attr_hash.fetch(:first)).to  be_truthy
    expect(target_object.all_bit_attr_hash.fetch(:second)).to be_falsey
    expect(target_object.all_bit_attr_hash.fetch(:third)).to  be_falsey

    target_object.my_bits = 0b100
    expect(target_object.all_bit_attr_hash.fetch(:first)).to  be_falsey
    expect(target_object.all_bit_attr_hash.fetch(:second)).to be_falsey
    expect(target_object.all_bit_attr_hash.fetch(:third)).to  be_truthy

    target_object.my_bits = 0b010
    expect(target_object.all_bit_attr_hash.fetch(:first)).to  be_falsey
    expect(target_object.all_bit_attr_hash.fetch(:second)).to be_truthy
    expect(target_object.all_bit_attr_hash.fetch(:third)).to  be_falsey
  end

  it "can write" do
    target_object.my_bits = 0b000
    target_object.first = true
    expect(target_object.my_bits).to eq 0b001
    target_object.second = true
    expect(target_object.my_bits).to eq 0b011
    target_object.first = false
    expect(target_object.my_bits).to eq 0b010
  end
end
