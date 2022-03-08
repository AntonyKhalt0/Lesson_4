require_relative 'train'

class PassengerTrain < Train
  attr_reader :type

  def initialize
    super
    @type = 'Passenger'
  end

end
