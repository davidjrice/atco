module Atco
  
  class ZLocation

    attr_accessor :record_identity, :type, :identifier,:name
    attr_writer :record_identity, :type, :identifier,:name

    def initialize(data)
      @record_identity = data[:record_identity]
      @type = data[:type]
      @identifier = data[:identifier]
      @name = data[:name]
    end
  end

end