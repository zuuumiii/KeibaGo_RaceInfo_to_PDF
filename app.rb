require 'combine_pdf'
require_relative 'initializer/grover'
require_relative 'lib/raceinfo_to_pdf'
require_relative 'lib/baba_list'

class Generate
  def self.execute!
    RaceinfoToPDF.generate!
  end
end

Generate.execute!
