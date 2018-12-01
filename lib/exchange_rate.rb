require "open-uri"
require 'nokogiri'
require_relative "xml_retriever"


class ExchangeRate

  def self.read_file()
    begin
    xmlfile = File.open('../data/fx.xml')
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

  def self.get_currency_reference_value(date, currency)
  # querying the xml with nokogiri returns the value as a Nokogiri::XML::NodeSet so the .text operator is used to
  # return a string which is then made into a float for the calculation of the fx rate
  reference_rate = @doc.xpath('//*[@time="'+"#{date}"+'"]/*[@currency="'+"#{currency}"+'"]/@rate').text.to_f
  return reference_rate
  end







  def self.validated?(date, base_currency, counter_currency)
    if date_is_not_found?(date)
      return "Date not found. Check that the date is in YYYY-DD-MM format and within the last 90 days"
    elsif list_currencies_for_date(date).include?(base_currency) == false
      return "Base currency #{base_currency} not found. Check currency is one of the following #{list_currencies_for_date(date).join(", ")}"
    elsif list_currencies_for_date(date).include?(counter_currency) == false
      return "Counter currency #{counter_currency} not found. Check currency is one of the following #{list_currencies_for_date(date).join(", ")}"
    else
      return true
    end
  end

  def self.at(date, base_currency, counter_currency)
    if File.exist?('../data/fx.xml') == false
      return "the reference file has not been created. Check config/schedule.rb or run cron_job.rb"
    else
      if File.zero?('../data/fx.xml')
        return "the reference file is empty. Check config/schedule.rb or run cron_job.rb"
      end
      read_file()
      if date.class == Date
        previous_date = date - 1
        previous_date.to_s
        date.to_s
        if date_is_not_found?(date)
          date = previous_date #try previous date as Date.today is sometimes not published within the day
        end
      end
      if validated?(date, base_currency, counter_currency) == true
        base_currency_value = get_currency_reference_value(date, base_currency)
        counter_currency_value = get_currency_reference_value(date, counter_currency)
        rate = base_currency_value / counter_currency_value
        return rate.round(2)
      else
        return validated?(date, base_currency, counter_currency)
      end

    end
  end











end
