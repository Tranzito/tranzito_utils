# frozen_string_literal: true

require "rails_helper"

RSpec.describe TranzitoUtils::GraphingHelper, type: :helper do
  describe "group_by_method" do
    context "hourly" do
      it "returns group_by_minute" do
        expect(group_by_method((Time.current - 1.hour)..Time.current)).to eq :group_by_minute
      end
    end

    context "daily" do
      it "returns group_by_hour" do
        expect(group_by_method((Time.current - 1.day)..Time.current)).to eq :group_by_hour
      end
    end

    context "weekly" do
      it "returns group_by_day" do
        expect(group_by_method((Time.current - 6.days)..Time.current)).to eq :group_by_day
      end
    end

    context "6 months" do
      it "returns group_by_week" do
        expect(group_by_method((Time.current - 6.months)..Time.current)).to eq :group_by_week
      end
    end

    context "2 years" do
      it "returns group_by_month" do
        expect(group_by_method((Time.current - 2.years)..Time.current)).to eq :group_by_month
      end
    end
  end

  describe "humanized_time_range_column" do
    it "humanizes created_at" do
      expect(humanized_time_range_column("created_at")).to eq "created"
      @period = "all"
      expect(humanized_time_range_column("created_at")).to be_blank
    end

    it "humanizes start_at and end_at" do
      expect(humanized_time_range_column("start_at")).to eq "starts"
      expect(humanized_time_range_column("end_at")).to eq "ends"
      expect(humanized_time_range_column("subscription_start_at")).to eq "subscription starts"
      expect(humanized_time_range_column("subscription_end_at")).to eq "subscription ends"
    end

    it "humanizes last_assigned_at" do
      expect(humanized_time_range_column("last_assigned_at")).to eq "last assigned"
    end

    it "humanizes updated_at" do
      expect(humanized_time_range_column("updated_at")).to eq "updated"
      @period = "all"
      expect(humanized_time_range_column("updated_at")).to be_blank
      @render_chart = true
      expect(humanized_time_range_column("updated_at")).to eq "updated"
    end

    it "humanizes needs_renewal_at" do
      expect(humanized_time_range_column("needs_renewal_at")).to eq "need renewal"
    end
  end

  describe "humanized_time_range" do
    context "standard time range" do
      it "returns period" do
        @period = "week"
        expect(humanized_time_range((Time.current - 1.week)..Time.current)).to eq "in the past week"
      end

      context "all" do
        it "returns period" do
          @period = "all"
          expect(humanized_time_range((Time.current - 1.week)..Time.current)).to be_blank
        end
      end

      context "next_week" do
        it "returns period" do
          @period = "next_week"
          expect(humanized_time_range((Time.current - 1.week)..Time.current)).to eq "in the next week"
        end
      end

      context "next_month" do
        it "returns period" do
          @period = "next_month"
          expect(humanized_time_range((Time.current - 1.week)..Time.current)).to eq "in the next month"
        end
      end
    end

    context "custom time period" do
      let(:end_time) { Time.at(1578268910) } # 2020-01-06 00:01:38 UTC
      let(:time_range) { start_time..end_time }
      before { @period = "custom" }

      context "45 minute long period" do
        let(:start_time) { end_time - 45.minutes }
        let(:target_html) do
          [
            'from <em class="convertTime preciseTimeSeconds">',
            start_time.strftime("%FT%T%z"),
            '</em> to <em class="convertTime preciseTimeSeconds">',
            end_time.strftime("%FT%T%z") + "</em>"
          ]
        end

        it "returns with preciseTimeSeconds" do
          expect(humanized_time_range(time_range)).to eq "<span>" + target_html.join + "</span>"
        end
      end

      context "2 hour long period" do
        let(:start_time) { end_time - 2.hours }
        let(:target_html) do
          [
            'from <em class="convertTime preciseTime">',
            start_time.strftime("%FT%T%z"),
            '</em> to <em class="convertTime preciseTime">',
            end_time.strftime("%FT%T%z") + "</em>"
          ]
        end

        it "returns time in precise time" do
          expect(humanized_time_range(time_range)).to eq "<span>" + target_html.join + "</span>"
        end

        context "ending now" do
          let(:end_time) { Time.current - 1.minute } # Because we send time by minute
          let(:current_target_html) { target_html.slice(0, 2) + ["</em> to <em>now</em>"] }
          it "returns time in precise time" do
            expect(humanized_time_range(time_range)).to eq "<span>" + current_target_html.join + "</span>"
          end
        end
      end

      context "week long period" do
        let(:start_time) { end_time - 7.days }
        let(:target_html) do
          [
            'from <em class="convertTime ">',
            start_time.strftime("%FT%T%z"),
            '</em> to <em class="convertTime ">',
            end_time.strftime("%FT%T%z") + "</em>"
          ]
        end

        it "returns with preciseTimeSeconds" do
          expect(humanized_time_range(time_range)).to eq "<span>" + target_html.join + "</span>"
        end
      end
    end
  end
end
