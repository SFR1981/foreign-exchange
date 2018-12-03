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




  def self.optimise_date(date)
    if date.class == String
      begin
        date = Date.parse(date)
      rescue => exception
        puts "date entered is of invalid format"
        return exception
      end
    end

    #Sometimes a submitted date of Date.today will turn up no results
    #the stored fx file is set to update at 3.15pm each day and the feed source
    # updates at around 3pm GMT.
    # if Date.today is used before 3:15pm
    # this method swaps the submitted date for the last date with stored values

    if date == Date.today
      update_time = Time.parse "3:15 pm"
      if Time.now < update_time
        date = date - 1
      end
    end
    # convert the date to the previous friday if that date falls on a saturday or sunday
    # as fx rates do not update at weekends
    case date.wday
    when 0
      return  (date -= 2).to_s
    when  6
      return  (date -=1).to_s
    else
      return date.to_s
    end

  end


  def self.at(date, base_currency, counter_currency)
    base_currency.upcase!
    counter_currency.upcase!
    if File.exist?(@fxFileLocation) == false
      return "the reference file has not been created. Check config/schedule.rb or run fx_create.rb"
    elsif File.zero?(@fxFileLocation)
      return "the reference file is empty. Check config/schedule.rb or run fx_create.rb"
    end

    read_file()
    date = optimise_date(date)
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
