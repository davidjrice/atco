module Atco
  
  class BankHoliday
    :record_identity => string[0,2],
    :transaction_type => string[2,1],
    :date_of_bank_holiday
    attr_accessor :record_identity, :transaction_type, :date_of_bank_holiday
    attr_writer :record_identity, :transaction_type, :date_of_bank_holiday

    def initialize(data)
      @record_identity = data[:record_identity]
      @transaction_type = data[:transaction_type]
      @date_of_bank_holiday = data[:date_of_bank_holiday]
    end
    
  end

end