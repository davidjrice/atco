module Atco
  
  class Operator

    attr_accessor :record_identity, :transaction_type, :operator, :operator_short_form, :operator_legal_name, :address
    attr_writer :record_identity, :transaction_type, :operator, :operator_short_form, :operator_legal_name, :address

    def initialize(data)
      @record_identity = data[:record_identity]
      @transaction_type = data[:transaction_type]
      @operator = data[:operator]
      @operator_short_form = data[:operator_short_form]
      @operator_legal_name = data[:operator_legal_name]
    end
    
  end

end