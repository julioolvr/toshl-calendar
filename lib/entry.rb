class Entry
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def date
    Date.strptime(data['date'], '%Y-%m-%d')
  end

  def recur
    repeat_data = @data['repeat']

    builder = ["FREQ=#{repeat_data['frequency']}", "INTERVAL=#{repeat_data['interval']}"]
    builder << "COUNT=#{repeat_data['count']}" if repeat_data.has_key?('count')
    builder << "BYDAY=#{repeat_data['byday']}" if repeat_data.has_key?('byday')
    builder << "BYMONTHDAY=#{repeat_data['bymonthday']}" if repeat_data.has_key?('bymonthday')
    builder << "BYSETPOS=#{repeat_data['bysetpos']}" if repeat_data.has_key?('bysetpos')

    builder.join(';')
  end

  def description
    data_description = data['desc'].strip

    if data_description != ''
      data_description
    else
      # TODO: Use other metadata to build a more useful description
      'Toshl Repeating Entry'
    end
  end
end
