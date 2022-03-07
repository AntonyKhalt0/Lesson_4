class Train
  attr_reader :number, :wagons, :route, :speed, :current_station

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def speed_dial(boost)
    self.speed += boost
  end

  def reduse_speed
    self.speed = 0
  end

  def attach_wagons(wagon)
    @wagons.push(wagon) if cheking_speed_and_wagon_type?(wagon)
  end

  def unpin_wagons(wagon_index)
    @wagons.delete_at(wagon_index) if checking_speed_and_wagon_type?(wagon)
  end

  def train_route(route)
    @route = route
    @current_station = route_stations.fisrt
  end

  def previous_station
    route_stations[current_stations_index.pred] if @current_station != route_stations.fisrt 
  end

  def next_station
    route_stations[current_stations_index.next] if @current_station != route_stations.last
  end

  def moving_back
    @current_station = previous_station if previous_station
  end

  def moving_forward
    @current_station = next_station if next_station
  end

  protected # Private заменил на protected, чтобы заприваченные методы были видны в классах-потомках
  attr_writer :speed # Переместил setter скорости, чтобы нельзя было изменять "из вне"

  def checking_speed_and_wagon_type?(wagon) # Методы дополнительного функционала вынес в protected
    self.speed.zero? && wagon_type(wagon)
  end

  def route_stations 
    @route.stations
  end

  def current_stations_index
    route_stations.index(@current_station)
  end

end
