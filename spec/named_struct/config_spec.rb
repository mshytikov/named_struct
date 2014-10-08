require 'spec_helper'

RSpec.describe NamedStruct::Config do
  describe ".new" do
    context "without arguments" do
      subject{ NamedStruct::Config.new}
      it { is_expected.to be_kind_of(NamedStruct::Config) }
      it { expect{ subject }.to_not raise_error }
    end

    context "with positional arguments" do
      subject{ NamedStruct::Config.new(10, 20)}
      let(:error_message) { "wrong arguments accepts only keyword arguments" }
      it { expect{ subject }.to raise_error(ArgumentError, error_message)}
    end

    context "with keyword arguments" do
      subject{ NamedStruct::Config.new(a: 10, b: 20)}
      let(:error_message) { "wrong number of arguments (2 for 0)" }
      it { expect{ subject }.to raise_error(ArgumentError, error_message)}
    end
  end

  describe "class MyConfig < NamedStruct::Config" do
    class MyConfig < NamedStruct::Config
      attr_required :a, :b
    end

    context "without arguments" do
      subject{ MyConfig.new}
      let(:error_message) { "missing keyword: a, b" }
      it { expect{ subject }.to raise_error(ArgumentError, error_message)}
    end

    context "with positional arguments" do
      subject{ MyConfig.new(10, 20)}
      let(:error_message) { "wrong arguments accepts only keyword arguments" }
      it { expect{ subject }.to raise_error(ArgumentError, error_message)}
    end

    context "with keyword arguments" do
      context "with missing required argumet" do
        context ":a missing" do
          subject{ MyConfig.new(b: 10)}
          let(:error_message) { "missing keyword: a" }
          it { expect{ subject }.to raise_error(ArgumentError, error_message)}
        end
        context ":b missing" do
          subject{ MyConfig.new(a: 10)}
          let(:error_message) { "missing keyword: b" }
          it { expect{ subject }.to raise_error(ArgumentError, error_message)}
        end
      end
    end
  end
end
