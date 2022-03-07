require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

def route_name(station_first, station_last)
  "#{station_first.name}-#{station_last.name}"
end

def route_selection(routes)
  routes.each_with_index { |route, i| puts "#{i.next} - #{route.name}" }
  puts "Введите номер маршрута"
  gets.chomp.to_i
end

def train(trains_list, train_number)
  puts "Введите номер поезда: "
  train_number = gets.chomp.to_i
  trains_list[trains_list.index(train_number)]
end

stations = [Station.new('Москва'), Station.new('Воронеж'), Station.new('Тула')] 
test_route_first = Route.new(route_name(stations[0], stations[2]), stations[0], stations[2])
test_route_second = Route.new(route_name(stations[2], stations[0]), stations[2], stations[0])
trains_list = [PassengerTrain.new(12345), CargoTrain.new(54321)]
routes = [test_route_first, test_route_second]

loop do
  puts "Введите 1, чтобы создать станцию. \n
        Введите 2, чтобы создать поезд. \n
        Введите 3, чтобы создать маршрут и управлять станциями в нем. \n
        Введите 4, чтобы назначить маршрут поезду. \n
        Введите 5, чтобы прицепить или отцепить вагоны от поезда. \n
        Введите 6, чтобы перемещать поезд по маршруту. \n
        Введите 7, чтобы просматривать список станций и список поездов на станции.
        Введите 8, чтобы выйти из программы. "
  choice = gets.chomp.to_i
  case choice
  when 1
    puts "Введите название станции: "
    station_name = gets.chomp
    station_name.capitalize!
    station = Station.new(station_name)
    stations.push(station)

  when 2
    puts "Введите номер поезда: "
    train_number = gets.chomp.to_i
    puts "Введите 1, чтобы создать пассажирский поезд \n
          Введите 2 чтобы создать грузовой поезд. \n
          Введите 3, чтобы вернуться обратно. "
    choice_type_train = gets.chomp.to_i
    case choice_type_train
    when 1
      trains_list.push(PassengerTrain.new(train_number))
    when 2
      trains_list.push(CargoTrain.new(train_number))
    when 3
      break
    end

  when 3
    puts "Введите 1, чтобы создать маршрут. \n
          Введите 2, чтобы просмотреть список станций маршрута. \n
          Введите 3, чтобы добавить станцию. \n
          Введите 4, чтобы удалить станцию. \n
          Введите 5, чтобы вернуться обратно."
    choice_route = gets.chomp.to_i
    case choice_route
    when 1
      stations.each_with_index { |station, index| puts "#{i.next} - #{station.name}" }
      puts "Введите номер первой и последней станции: "
      station_first = gets.chomp.to_i
      station_last = gets.chomp.to_i
      routes.push(Route.new(route_name(stations[station_first.pred], stations[station_last.pred]), 
                            stations[station_first.pred], stations[station_last.pred]))
    when 2
      route_number = route_selection(routes)
      routes[route_number.pred].show_stations
    when 3
      route_number = route_selection(routes)
      routes[route_number.pred].show_stations
      puts "Введите номер станции, после которой добавить новую: "
      pred_station_number = gets.chomp.to_i
      puts "Список доступных станций: "
      stations.each_with_index { |station, index| puts "Станция - #{station.name}" unless stations.include? station }
      puts "Выберите станцию: "
      station_name = gets.chomp
      station_name.capitalize!
      routes[route_number.pred].add_station(pred_station_number, stations[stations.index(station_name)])
    when 4
      route_number = route_selection(routes)
      routes[route_number.pred].show_stations
      puts "Выберите станцию, которую хотите удалить из маршрута: "
      station_name = gets.chomp
      station_name.capitalize!
      routes[route_number.pred].delete_station(stations[stations.index(station_name)])
    when 5 
      break
    end

  when 4
    puts "Введите 1, чтобы добавить маршрут. \n
          Введите 2, чтобы вернуться обратно. "
    choice_type_train = gets.chomp.to_i
    case choice_type_train
    when 1
      current_train = train(trains_list, train_number)
      route_number = route_selection(routes)
      current_train.train_route(routes[route_number.pred])
      routes[route_number.pred].stations.first.add_train(current_train)
    when 2
      break
    end

  when 5
    current_train = train(trains_list, train_number, routes)
    puts "Введите 1, чтобы добавить вагон. \n
          Введите 2, чтобы отцепить вагон. \n
          Введите 3, чтобы вернуться обратно."
    select_action_with_wagon = gets.chomp.to_i
    case select_action_with_wagon
    when 1
      current_train.attach_wagons(PassengerWagon.new) if current_train.type == 'Passenger'
      current_train.attach_wagons(CargoWagon.new) if current_train.type == 'Cargo'
    when 2
      puts "Количеcтво вагонов поезда: #{current_train.wagons.length}"
      puts "Введите номер удаляемого вагона: "
      wagon_index = gets.chomp.to_i
      current_train.unpin_wagons(wagon_index)
    when 3
      break
    end

  when 6
    current_train = train(trains_list, train_number, routes)
    puts "Введите 1, чтобы переместить поезд вперед на одну станцию. \n
          Введите 2, чтобы переместить поезд назад на одну станцию. \n
          Введите 3, чтобы вернуться обратно."
    moving = gets.chomp
    case moving
    when 1
      if current_train.moving_forward
        current_train.route.stations[stations.index(current_train.current_station)].send_train(current_train)
        current_train.route.stations[stations.index(current_train.current_station).next].add_train(current_train)
      end
    when 2
      if current_train.moving_back
        current_train.route.stations[stations.index(current_train.current_station)].send_train(current_train)
        current_train.route.stations[stations.index(current_train.current_station).pred].add_train(current_train)
      end
    when 3
      break
    end

  when 7
    stations.each_with_index do |station, index|
      puts "Станция - #{station.name}. Поезда на станции: "
      station.trains_list.each { |train| puts "#{train.number}" }
    end

  when 8
    puts "До свидания!"
    break
  end

end
