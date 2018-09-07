class Renter
  attr_reader :name,
              :credit_card_number,
              :charges

  def initialize(name, credit_card_number)
    @name = name
    @credit_card_number = credit_card_number
    @charges = 0
  end

  def add_charge(charge)
    @charges += charge
  end
end
