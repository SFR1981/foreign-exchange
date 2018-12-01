require "open-uri"
require 'nokogiri'
require_relative "xml_retriever"


class ExchangeRate

  def read_file
  xmlfile = File.open('../data/fx.xml')
  @doc = Nokogiri::XML(xmlfile)
  xmlfile.close
  end

  # def reference_file_exists
  #
  #
  # end




  def validated?(date, base_currency, counter_currency)
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
    read_file
    # reference_file_exists
    if validated?(date, base_currency, counter_currency) == true
      base_currency_value = get_base_currency_reference_value(date, base_currency)
      counter_currency_value = get_counter_currency_reference_value(date, counter_currency)
      rate = base_currency_value / counter_currency_value
      return rate
    else
      return validated?(date, base_currency, counter_currency)
    end
  end











end
