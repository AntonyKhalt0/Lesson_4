class Station
  attr_reader :name
  attr_reader :trains_list

  def initialize(name)
    @name = name
    @trains_list = []
  end

  def add_train(train)
    @train_list.push(train)
  end

  def send_train(train) 
    @trains_list.delete(train) if @trains_list.include? train
  end

  def show_trains_on_station_by_type(type)
    @trains_list.select { |train| train.type == type }
  end

end
