require "rails_helper"
base_url = "/"
RSpec.describe base_url, type: :request do
  let(:stubtime) { Time.current.change(nsec: 0) }
  let(:earliest_period_time) { Time.at(stubtime.to_i) }

  describe "GET index" do
    before do
      allow(Time).to receive(:current).and_return(stubtime)
    end

    it "without params for period" do
      get base_url

      expect(assigns(:period)).to eq("all")
      expect(assigns(:start_time)).to eq(TranzitoUtils::DEFAULT[:earliest_period_time])
      expect(response).to render_template("home/index")
      expect(response).to render_template(partial: "_period_select")
    end

    it "with params contain search_at" do
      get base_url, params: {search_at: stubtime}

      expect(assigns(:period)).to eq("custom")
      expect(assigns(:search_at)).to eq(stubtime)
      expect(assigns(:start_time)).to eq(stubtime - 10.minutes.to_i)
      expect(assigns(:end_time)).to eq(stubtime + 10.minutes.to_i)
      expect(response).to render_template("home/index")
      expect(response).to render_template(partial: "_period_select")
    end

    it "with params, having period eq to hour" do
      get base_url, params: {period: "hour"}

      expect(assigns(:period)).to eq("hour")
      expect(assigns(:start_time)).to eq(stubtime - 1.hour)
    end

    it "with params, having period eq to day" do
      get base_url, params: {period: "day"}

      expect(assigns(:period)).to eq("day")
      expect(assigns(:start_time)).to eq(stubtime.beginning_of_day - 1.day)
      expect(response).to render_template("home/index")
      expect(response).to render_template(partial: "_period_select")
    end

    it "with params, having period eq to month" do
      get base_url, params: {period: "month"}

      expect(assigns(:period)).to eq("month")
      expect(assigns(:start_time)).to eq(stubtime.beginning_of_day - 30.days)
    end

    it "with params, having period eq to year" do
      get base_url, params: {period: "year"}

      expect(assigns(:period)).to eq("year")
      expect(assigns(:start_time)).to eq(stubtime.beginning_of_day - 1.year)
    end

    it "with params, having period eq to week" do
      get base_url, params: {period: "week"}

      expect(assigns(:period)).to eq("week")
      expect(assigns(:start_time)).to eq(stubtime.beginning_of_day - 1.week)
      expect(response).to render_template("home/index")
      expect(response).to render_template(partial: "_period_select")
    end

    it "with params, having period eq to next_month" do
      get base_url, params: {period: "next_month"}

      expect(assigns(:period)).to eq("next_month")
      expect(assigns(:start_time)).to eq(stubtime)
      expect(assigns(:end_time)).to eq(stubtime.beginning_of_day + 30.days)
    end

    it "with params, having period eq to next_week" do
      get base_url, params: {period: "next_week"}

      expect(assigns(:period)).to eq("next_week")
      expect(assigns(:start_time)).to eq(stubtime)
      expect(assigns(:end_time)).to eq(stubtime.beginning_of_day + 1.week)
    end

    context "with params, having period eq to custom" do
      context "with start_time and end_time" do
        it "having start_time > end_time" do
          get base_url, params: {period: "custom", start_time: stubtime + 1.week, end_time: stubtime}

          expect(assigns(:start_time)).to eq(stubtime)
          expect(assigns(:end_time)).to eq(stubtime + 1.week)
        end

        it "having start_time < end_time" do
          get base_url, params: {period: "custom", start_time: stubtime, end_time: stubtime + 1.day}

          expect(assigns(:start_time)).to eq(stubtime)
          expect(assigns(:end_time)).to eq(stubtime + 1.day)
        end
      end

      it "without start_time and end_time" do
        get base_url, params: {period: "custom"}

        expect(assigns(:period)).to eq("all")
        expect(assigns(:start_time)).to eq(TranzitoUtils::DEFAULT[:earliest_period_time])
      end
    end
  end

  describe "GET index with altered default values" do
    before do
      TranzitoUtils::DEFAULT[:earliest_period_time] = earliest_period_time
      allow(Time).to receive(:current).and_return(stubtime)
    end

    describe "for earliest_period_time" do
      it "without params for period" do
        get base_url

        expect(assigns(:period)).to eq("all")
        expect(assigns(:start_time)).to eq(earliest_period_time)
        expect(response).to render_template("home/index")
        expect(response).to render_template(partial: "_period_select")
      end

      context "with params, having period eq to custom" do
        it "without start_time and end_time" do
          get base_url, params: {period: "custom"}

          expect(assigns(:period)).to eq("all")
          expect(assigns(:start_time)).to eq(earliest_period_time)
        end
      end
    end
  end
end
