# ExchangeRate


## Dependencies

It will be necessary have installed the following gems;

gem install whenever <br/>
gem install nokogiri


## Usage
To use ExchangeRate, place the ExchangeRate folder within your base level of your project directory.


ExchangeRate has been set up to use whenever to run a daily task (cron). At first it will need be necessary
to update the crontab.
To do this, run the following command at the base of the ExchangeRate directory;

 'whenever --update-crontab'

To use the ExchangeRate class, require it in like this;<br/>
require_relative './ExchangeRate/lib/exchange_rate'

## Changing the cron job
To alter the time that this cron job is carried out you may edit the schedule.rb file in the config folder.
Each time you edit the schedule.rb file, you will need to enter this command in the terminal at the base
 of the ExchangeRate directory to update the task(s);
  'whenever --update-crontab'
  It may be helpful to read the ReadMe at https://github.com/javan/whenever to see how cron tasks may be configured.
