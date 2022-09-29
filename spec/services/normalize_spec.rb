# frozen_string_literal: true

require "rails_helper"

RSpec.describe TranzitoUtils::Normalize do
  describe "boolean" do
    context "1" do
      it "returns true" do
        expect(TranzitoUtils::Normalize.boolean(1)).to eq true
        expect(TranzitoUtils::Normalize.boolean(" 1")).to eq true
      end
    end
    context "true" do
      it "returns true" do
        expect(TranzitoUtils::Normalize.boolean(true)).to eq true
        expect(TranzitoUtils::Normalize.boolean("true ")).to eq true
      end
    end
    context "random string" do
      it "returns true" do
        expect(TranzitoUtils::Normalize.boolean("something in here")).to eq true
      end
    end
    context "nil" do
      it "returns false" do
        expect(TranzitoUtils::Normalize.boolean).to eq false
        expect(TranzitoUtils::Normalize.boolean(nil)).to eq false
      end
    end
    context "false" do
      it "returns false" do
        expect(TranzitoUtils::Normalize.boolean(false)).to eq false
        expect(TranzitoUtils::Normalize.boolean("false\n")).to eq false
      end
    end
  end
end
