class Entry
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def date
    Date.strptime(data['date'], '%Y-%m-%d')
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
