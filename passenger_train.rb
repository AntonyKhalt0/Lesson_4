require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize
    super
    @type = 'Passenger'
  end

  private # Заприватил т.к. метод дополнительного функционала

  def wagon_type(wagon)
    wagon.type == 'Passenger'
  end

end
