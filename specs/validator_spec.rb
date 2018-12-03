require("minitest/autorun")
require 'nokogiri'
require_relative("../lib/validator")



class TestValidator< MiniTest::Test

  def setup
    test_file_location = File.expand_path('../data/test.xml', __dir__)
    xmlfile = File.open(test_file_location)
    @doc = Nokogiri::XML(xmlfile)
    xmlfile.close
    @currency_array = ["USD", "JPY", "BGN", "CZK", "DKK", "GBP",
       "HUF", "PLN", "RON", "SEK", "CHF", "ISK", "NOK", "HRK",
       "RUB", "TRY", "AUD", "BRL", "CAD", "CNY", "HKD", "IDR",
       "ILS", "INR", "KRW", "MXN", "MYR", "NZD", "PHP", "SGD",
       "THB", "ZAR"]
  end


  def test_can_list_currencies_for_date
    assert_equal(@currency_array, Validator.list_currencies_for_date("2018-11-30",@doc))
  end

  def test_can_handle_if_date_is_not_found__true
    assert_equal(true, Validator.date_is_not_found?("2018-10-7",@doc))
  end

  def test_can_handle_if_date_is_not_found__false
    assert_equal(false, Validator.date_is_not_found?("2018-11-30",@doc))
  end

  def test_can_check_values_are_valid___all_valid
    assert_equal(true, Validator.validated?("2018-11-30", "GBP", "USD", @doc))
  end

  def test_can_check_values_are_valid__invalid_date
    assert_equal("Date not found. Check that the date is in YYYY-DD-MM format and within the last 90 days",
       Validator.validated?("2-11-30", "GBP", "USD", @doc))
  end

  def test_can_check_values_are_valid__invalid_base_currency
    assert_equal("Base currency 'Test' not found. Check currency is valid",
      Validator.validated?("2018-11-29", "Test", "USD", @doc))
  end

  def test_can_check_values_are_valid__invalid_counter_currency
    assert_equal("Counter currency 'Test' not found. Check currency is valid",Validator.validated?("2018-11-29", "GBP", "Test", @doc))
  end


end
