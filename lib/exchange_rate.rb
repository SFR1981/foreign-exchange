require "open-uri"
require 'nokogiri'
require_relative "xml_retriever"
require_relative "validator"


class ExchangeRate

  @fxFileLocation = File.expand_path('../data/fx.xml', __dir__)

  def self.read_file()
    begin
    xmlfile = File.open(@fxFileLocation)
    rescue => exception
      puts exception
    end
    @doc = Nokogiri::XML(xmlfile)
    xmlfile.close
    return "file has been read"
  end

  # querying the xml with nokogiri returns the value as a Nokogiri::XML::NodeSet so the .text operator is used to
  # return a string which is then made into a float for the calculation of the fx rate
  def self.get_currency_reference_value(date, currency, doc=@doc)
    doc.xpath('//*[@time="'+"#{date}"+'"]/*[@currency="'+"#{currency}"+'"]/@rate').text.to_f
  end


  #the purpose of this method is to take a date object and return it as a string
  # it will convert the date to the previous friday if that date falls on a saturday or sunday
  # as it seems fx rates do not update at weekends
  def self.optimise_date_object(date)
    if date.class == String
      date = Date.parse(date)
    end
    if date.wday == 0 || date.wday== 6
      days_before = (date.wday + 1) % 7 + 1
      puts "days before next line"
      puts days_before
      puts date.to_date - days_before
      return (date.to_date - days_before).to_s
    else
      return date.to_s
    end
  end


  def self.at(date, base_currency, counter_currency)
    if File.exist?(@fxFileLocation) == false
      return "the reference file has not been created. Check config/schedule.rb or run fx_create.rb"
    elsif File.zero?(@fxFileLocation)
      return "the reference file is empty. Check config/schedule.rb or run fx_create.rb"
    end
    read_file()
    date = optimise_date_object(date)
    if Validator.validated?(date, base_currency, counter_currency, @doc) == true
      base_currency_value = get_currency_reference_value(date, base_currency)
      counter_currency_value = get_currency_reference_value(date, counter_currency)
      rate = base_currency_value / counter_currency_value
      return rate.round(2)
    else
      return Validator.validated?(date, base_currency, counter_currency, @doc)
    end
  end



end
