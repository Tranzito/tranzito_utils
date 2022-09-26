# frozen_string_literal: true

require "rails_helper"

RSpec.describe TranzitoUtils::ParamsNormalizer do
  describe "boolean" do
    context "1" do
      it "returns true" do
        expect(TranzitoUtils::ParamsNormalizer.boolean(1)).to eq true
        expect(TranzitoUtils::ParamsNormalizer.boolean(" 1")).to eq true
      end
    end
    context "true" do
      it "returns true" do
        expect(TranzitoUtils::ParamsNormalizer.boolean(true)).to eq true
        expect(TranzitoUtils::ParamsNormalizer.boolean("true ")).to eq true
      end
    end
    context "random string" do
      it "returns true" do
        expect(TranzitoUtils::ParamsNormalizer.boolean("something in here")).to eq true
      end
    end
    context "nil" do
      it "returns false" do
        expect(TranzitoUtils::ParamsNormalizer.boolean).to eq false
        expect(TranzitoUtils::ParamsNormalizer.boolean(nil)).to eq false
      end
    end
    context "false" do
      it "returns false" do
        expect(TranzitoUtils::ParamsNormalizer.boolean(false)).to eq false
        expect(TranzitoUtils::ParamsNormalizer.boolean("false\n")).to eq false
      end
    end
  end
end
