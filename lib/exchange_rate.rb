require "open-uri"
require 'nokogiri'
require_relative "xml_retriever"
require_relative "Validator"


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

  def self.list_currencies_for_date(date, doc=@doc)
    currencies = doc.xpath('//*[@time="'+"#{date}"+'"]')
    currency_array = []
    currencies.children.each do |currency|
      currency_array << "#{currency.attr('currency')}"
    end
    return currency_array
  end



  def self.date_is_not_found?(date, doc=@doc)
    nodeset = doc.xpath('//*[@time="'+"#{date}"+'"]')
    return nodeset.empty?
  end

  def self.get_currency_reference_value(date, currency, doc=@doc)
  # querying the xml with nokogiri returns the value as a Nokogiri::XML::NodeSet so the .text operator is used to
  # return a string which is then made into a float for the calculation of the fx rate
  reference_rate = doc.xpath('//*[@time="'+"#{date}"+'"]/*[@currency="'+"#{currency}"+'"]/@rate').text.to_f
  return reference_rate
  end


  def self.validated?(date, base_currency, counter_currency, doc=@doc)
    list_of_currencies = list_currencies_for_date(date, doc)
    if date_is_not_found?(date, doc)
      return "Date not found. Check that the date is in YYYY-DD-MM format and within the last 90 days"
    elsif list_of_currencies.include?(base_currency) == false
      return "Base currency '#{base_currency}' not found. Check currency is valid"
    elsif list_of_currencies.include?(counter_currency) == false
      return "Counter currency '#{counter_currency}' not found. Check currency is valid"
    else
      return true
    end
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
    if validated?(date, base_currency, counter_currency, @doc) == true
      base_currency_value = get_currency_reference_value(date, base_currency)
      counter_currency_value = get_currency_reference_value(date, counter_currency)
      rate = base_currency_value / counter_currency_value
      return rate.round(2)
    else
      return validated?(date, base_currency, counter_currency, @doc)
    end
  end



end
