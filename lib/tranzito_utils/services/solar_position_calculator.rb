require "time"

class SolarPositionCalculator
  LATITUDE_RANGE = (-90..90)
  LONGITUDE_RANGE = (-180..180)

  attr_reader :latitude, :longitude, :timezone

  def initialize(latitude, longitude, timezone)
    validate_latitude(latitude)
    validate_longitude(longitude)
    @latitude = latitude
    @longitude = longitude
    @timezone = timezone
  end

  def sunrise_time(date)
    calculate_sun_time(date, :sunrise)
  end

  def sunset_time(date)
    calculate_sun_time(date, :sunset)
  end

  private

  def calculate_sun_time(date, type)
    validate_date(date)
    utc_time = calculate_utc_time(date, type)
    utc_to_timezone(date, utc_time)
  end

  def calculate_utc_time(date, type)
    time = Time.new(date.year, date.month, date.day, 12, 0, 0, timezone)
    gamma = calculate_gamma(time)
    eqtime = calculate_eqtime(gamma)

    decl = calculate_decl(gamma)
    ha = calculate_ha(decl)
    calculate_sun_time_utc(ha, eqtime, type)
  end

  def calculate_sun_time_utc(ha, eqtime, type)
    if type == :sunrise
      720 - 4 * (longitude + ha * 180 / Math::PI) - eqtime
    else
      720 - 4 * (longitude - ha * 180 / Math::PI) - eqtime
    end
  end

  def calculate_gamma(time)
    2 * Math::PI / (leap_year?(time.year) ? 366 : 365) * (time.yday - 1 + (time.hour - 12) / 24.0)
  end

  def calculate_eqtime(gamma)
    229.18 * (0.000075 + 0.001868 * Math.cos(gamma) - 0.032077 * Math.sin(gamma) - 0.014615 * Math.cos(2 * gamma) - 0.040849 * Math.sin(2 * gamma))
  end

  def calculate_decl(gamma)
    0.006918 - 0.399912 * Math.cos(gamma) + 0.070257 * Math.sin(gamma) - 0.006758 * Math.cos(2 * gamma) + 0.000907 * Math.sin(2 * gamma) - 0.002697 * Math.cos(3 * gamma) + 0.00148 * Math.sin(3 * gamma)
  end

  def calculate_ha(decl)
    Math.acos(Math.cos(Math::PI / 180 * 90.833) / (Math.cos(Math::PI / 180 * latitude) * Math.cos(decl)) - Math.tan(Math::PI / 180 * latitude) * Math.tan(decl))
  end

  def utc_to_timezone(date, utc_time)
    response = Time.parse("#{date.year}-#{date.month}-#{date.day}T#{Time.at(utc_time * 60).utc.strftime("%H:%M:%S")}") + timezone * 3600
    response.strftime("%H:%M:%S")
  end

  def leap_year?(year)
    year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
  end

  def validate_latitude(latitude)
    raise ArgumentError, "Latitude should be between -90 and 90 degrees" unless LATITUDE_RANGE.include?(latitude)
  end

  def validate_longitude(longitude)
    raise ArgumentError, "Longitude should be between -180 and 180 degrees" unless LONGITUDE_RANGE.include?(longitude)
  end

  def validate_date(date)
    raise ArgumentError, "Invalid date" unless date.is_a?(Date)
  end
end
