# ExchangeRate


## Dependencies
Before running;
It will be necessary to have installed the following gems;

gem install whenever <br/>
gem install nokogiri


## Usage
To use ExchangeRate, place the ExchangeRate folder within the base directory of your project.

The reference file will initially be out of date and this will be updated by the scheduled task at 3.15pm, however
you may want to update it to start with. This can be done by running "ruby ExchangeRate/lib/fx_create.rb"  


ExchangeRate has been set up to use the whenever gem to run a daily task (cron). At first it will be necessary
to update the crontab.
To do this, run the following command at the base of the ExchangeRate directory;

 'whenever --update-crontab'

To use the ExchangeRate class, require it in like this;<br/>
require_relative './ExchangeRate/lib/exchange_rate'

Call the 'at' method like this;
ExchangeRate.at(date, base currency, counter currency)

The date parameter may be either a Date object like Date.today or a String which should be in the format 'YYYY-MM-DD' <br/>
The base currency and counter currency parameters should be a string matching (case insensitive) any of these currency abbreviations:- <br/>
"USD", "JPY", "BGN",<br/>
"CZK", "DKK", "GBP",<br/>
"HUF", "PLN", "RON",<br/>
"SEK", "CHF", "ISK",<br/>
"NOK", "HRK", "RUB",<br/>
"TRY", "AUD", "BRL",<br/>
"CAD", "CNY", "HKD",<br/>
"IDR", "ILS", "INR",<br/>
"KRW", "MXN", "MYR",<br/>
"NZD", "PHP", "SGD",<br/>
"THB", "ZAR"



## Changing the cron job
To alter the time that this cron job is carried out you may edit the schedule.rb file in the config folder.
Each time you edit the schedule.rb file, you will need to enter this command in the terminal at the base
 of the ExchangeRate directory to update the crontab;
  'whenever --update-crontab'
  It may be helpful to read the ReadMe at https://github.com/javan/whenever to see how cron tasks may be configured using the whenever gem.
