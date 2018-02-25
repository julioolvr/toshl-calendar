require 'icalendar'

class Calendar
  def initialize(entries)
    @entries = entries
  end

  def ical
    icalendar = Icalendar::Calendar.new

    @entries.each do |entry|
      date = Date.strptime(entry['date'], '%Y-%m-%d')
      description = entry['desc'].strip

      if description == ''
        # TODO: Use other metadata to build a more useful description
        description = 'Toshl Repeating Entry'
      end

      icalendar.event do |event|
        event.dtstart = Icalendar::Values::Date.new(date.strftime('%Y%m%d'))
        event.summary = description
      end
    end

    icalendar.to_ical
  end
end
