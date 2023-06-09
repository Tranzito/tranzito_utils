# frozen_string_literal: true

require "rails_helper"

RSpec.describe SolarPositionCalculator do
  let(:latitude) { 34.052235 }
  let(:longitude) { -118.243683 }
  let(:timezone) { -7 }
  let(:calculator) { SolarPositionCalculator.new(latitude, longitude, timezone) }

  describe "#initialize" do
    context "with valid latitude, longitude, and timezone" do
      it "does not raise an error" do
        expect { calculator }.not_to raise_error
      end
    end

    context "with invalid latitude" do
      it "raises an ArgumentError" do
        invalid_latitude = -100

        expect { SolarPositionCalculator.new(invalid_latitude, longitude, timezone) }
          .to raise_error(ArgumentError, "Latitude should be between -90 and 90 degrees")
      end
    end

    context "with invalid longitude" do
      it "raises an ArgumentError" do
        invalid_longitude = 200

        expect { SolarPositionCalculator.new(latitude, invalid_longitude, timezone) }
          .to raise_error(ArgumentError, "Longitude should be between -180 and 180 degrees")
      end
    end
  end

  describe "#sunrise_time" do
    it "returns the correct sunrise time for a given date" do
      date = Date.new(2023, 6, 9)
      expected_sunrise_time = "05:40:57"

      sunrise_time = calculator.sunrise_time(date)

      expect(sunrise_time).to eq(expected_sunrise_time)
    end

    context "with invalid date" do
      it "raises an ArgumentError" do
        invalid_date = "2023-06-09" # Not a Date object

        expect { calculator.sunrise_time(invalid_date) }
          .to raise_error(ArgumentError, "Invalid date")
      end
    end
  end

  describe "#sunset_time" do
    it "returns the correct sunset time for a given date" do
      date = Date.new(2023, 6, 9)
      expected_sunset_time = "20:02:36"

      sunset_time = calculator.sunset_time(date)

      expect(sunset_time).to eq(expected_sunset_time)
    end

    context "with invalid date" do
      it "raises an ArgumentError" do
        invalid_date = "2023-06-09" # Not a Date object

        expect { calculator.sunset_time(invalid_date) }
          .to raise_error(ArgumentError, "Invalid date")
      end
    end
  end
end
