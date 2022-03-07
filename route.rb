class Route
  attr_reader :name, :stations

  def intialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
  end

  def add_station(previous_station, new_station)
    @stations.insert(@stations.index(previous_station) + 1, new_station)
  end

  def delete_station(selected_station)
    @stations.delete(selected_station)
  end

  def show_stations
    @stations.each_with_index { |station, index| "#{index.next} - станция: #{station.name}" }
  end

end
