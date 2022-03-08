require_relative 'train'

class CargoTrain < Train
  attr_reader :type

  def initialize
    super
    @type = 'Cargo'
  end

end
