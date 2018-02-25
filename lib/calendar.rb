require 'icalendar'

class Calendar
  def initialize(entries)
    @entries = entries
  end

  def ical
    icalendar = Icalendar::Calendar.new

    @entries.each do |entry|
      icalendar.event do |event|
        event.dtstart = Icalendar::Values::Date.new(entry.date.strftime('%Y%m%d'))
        event.summary = entry.description
        event.rrule = Icalendar::Values::Recur.new(entry.recur)
      end
    end

    icalendar.to_ical
  end
end
