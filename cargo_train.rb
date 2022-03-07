require_relative 'train'

class CargoTrain < Train
  attr_reader :type

  def initialize
    super
    @type = 'Cargo'
  end

  private  # Заприватил т.к. метод дополнительного функционала

  def wagon_type(wagon)
    wagon.type == 'Cargo'
  end

end
