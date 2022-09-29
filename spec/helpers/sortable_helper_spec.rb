# frozen_string_literal: true

require "rails_helper"

RSpec.describe TranzitoUtils::SortableHelper, type: :helper do
  before { controller.params = ActionController::Parameters.new(passed_params) }

  describe "sortable_search_params with default search_params" do
    context "no sortable_search_params" do
      let(:passed_params) { {party: "stuff"} }
      it "returns an empty hash" do
        expect(sortable_search_params.to_unsafe_h).to eq({})
      end
    end
    context "direction, sort" do
      let(:passed_params) { {direction: "asc", sort: "stolen", party: "long"} }
      let(:target) { {direction: "asc", sort: "stolen"} }
      it "returns an empty hash" do
        expect(sortable_search_params.to_unsafe_h).to eq(target.as_json)
        expect(sortable_search_params?).to be_falsey
      end
    end
    context "direction, sort, period: all " do
      let(:passed_params) { {direction: "asc", sort: "stolen", period: "all"} }
      let(:target) { {direction: "asc", sort: "stolen", period: "all"} }
      it "returns an empty hash" do
        expect(sortable_search_params?).to be_falsey
      end
    end
    context "direction, sort, period: week" do
      let(:passed_params) { {direction: "asc", sort: "stolen", period: "week"} }
      let(:target) { {direction: "asc", sort: "stolen", period: "week"} }
      it "returns an empty hash" do
        expect(sortable_search_params?).to be_truthy
        expect(sortable_search_params?(except: [:period])).to be_falsey
      end
    end
    context "direction, sort, search param, user_id" do
      let(:passed_params) { {direction: "asc", sort: "stolen", party: "long", search_stuff: "xxx", user_id: 21, query: "something"} }
      let(:target) { {direction: "asc", sort: "stolen", search_stuff: "xxx", user_id: 21, query: "something"} }
      it "returns an empty hash" do
        expect(sortable_search_params.to_unsafe_h).to eq(target.as_json)
        expect(sortable_search_params?).to be_truthy
        expect(sortable_search_params?(except: [:user_id])).to be_truthy
        expect(sortable_search_params?(except: [:search_stuff, :user_id, :query])).to be_falsey
      end
    end
  end

  describe "sortable_search_params with additional_search_keys" do
    context "Add party into additional_search_keys default array" do
      let(:passed_params) { {direction: "asc", sort: "stolen", party: "long"} }
      let(:target) { {direction: "asc", sort: "stolen", party: "long"} }

      it "returns an empty hash" do
        allow(TranzitoUtils::DEFAULT).to receive(:[]).with(:additional_search_keys).and_return([:party])

        expect(sortable_search_params.to_unsafe_h).to eq(target.as_json)
        expect(sortable_search_params?).to be_truthy
        expect(sortable_search_params?(except: [:party])).to be_falsey
      end
    end

    context "With empty additional_search_keys" do
      let(:passed_params) { {direction: "asc", sort: "stolen"} }
      let(:target) { {direction: "asc", sort: "stolen"} }

      it "returns an empty hash" do
        allow(TranzitoUtils::DEFAULT).to receive(:[]).with(:additional_search_keys).and_return([])

        expect(sortable_search_params.to_unsafe_h).to eq(target.as_json)
        expect(sortable_search_params?).to be_falsey
      end
    end
  end
end
