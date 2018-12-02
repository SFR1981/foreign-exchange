require 'nokogiri'

class Validator

  @fxFileLocation = File.expand_path('../data/fx.xml', __dir__)

  def self.date_is_not_found?(date, doc)
    nodeset = doc.xpath('//*[@time="'+"#{date}"+'"]')
    return nodeset.empty?
  end

  def self.list_currencies_for_date(date, doc)
    currencies = doc.xpath('//*[@time="'+"#{date}"+'"]')
    currency_array = []
    currencies.children.each do |currency|
      currency_array << "#{currency.attr('currency')}"
    end
    return currency_array
  end



  def self.validated?(date, base_currency, counter_currency, doc)
    list_of_currencies = list_currencies_for_date(date, doc)
    if File.exist?(@fxFileLocation) == false
      return "the reference file has not been created. Check config/schedule.rb or run fx_create.rb"
    elsif File.zero?(@fxFileLocation)
      return "the reference file is empty. Check config/schedule.rb or run fx_create.rb"
    end
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


end
