require("minitest/autorun")
require 'nokogiri'
require_relative("../lib/exchange_rate")
require_relative "../lib/xml_retriever"


class TestExchangeRate < MiniTest::Test

  def setup
    XmlRetriever.xmlGet
    xmlfile = File.open('../data/test.xml')
    @doc = Nokogiri::XML(xmlfile)
    xmlfile.close
    @currency_array = ["USD", "JPY", "BGN", "CZK", "DKK", "GBP",
       "HUF", "PLN", "RON", "SEK", "CHF", "ISK", "NOK", "HRK",
       "RUB", "TRY", "AUD", "BRL", "CAD", "CNY", "HKD", "IDR",
       "ILS", "INR", "KRW", "MXN", "MYR", "NZD", "PHP", "SGD",
       "THB", "ZAR"]
  end

  def test_can_read_file
    assert_equal("file has been read", ExchangeRate.read_file)
  end

  def test_can_handle_no_file
    File.delete("../data/fx.xml")
    assert_equal("the reference file has not been created. Check config/schedule.rb or run fx_create.rb",
      ExchangeRate.at(Date.today,"GBP","USD"))
    XmlRetriever.xmlGet
  end

  def test_can_handle_empty_reference_file
    File.truncate("../data/fx.xml", 0)
    assert_equal("the reference file is empty. Check config/schedule.rb or run fx_create.rb",
      ExchangeRate.at(Date.today,"GBP","USD"))
    XmlRetriever.xmlGet
  end

  def test_can_get_currency_reference_value
    assert_equal(0.89068, ExchangeRate.get_currency_reference_value("2018-11-30", "GBP", @doc))
  end

  def test_can_optimise_date__not_weekend
    assert_equal("2018-11-29", ExchangeRate.optimise_date_object(Date.parse("2018-11-29")))
  end

  def test_can_optimise_date__weekend
    assert_equal("2018-11-30", ExchangeRate.optimise_date_object(Date.parse("2018-12-02")))
  end

  # ExchangeRate.at can accept date as a string (e.g. from a post from an html form drop down list option)
  def test_method_returns_exchange_rate__given_date_as_string
    assert_equal(0.78,ExchangeRate.at("2018-11-29","GBP","USD"))
  end

  def test_method_returns_exchange_rate__given_date_as_date_object
    assert_equal(0.78,ExchangeRate.at(Date.today,"GBP","USD"))
  end


end
