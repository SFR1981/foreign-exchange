# ExchangeRate

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/sfr`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Dependencies

This library users the whenever gem to allow for a cron job that schedules an update for the xml file.

  $ gem install whenever

To alter the time this cron job is carried out you may edit the schedule.rb file in the config folder.
If you decide to edit the schedule.rb file you will need to enter this command in the terminal at the base directory of Exchangerate : 'whenever --update-crontab'

## Usage

TODO: Write usage instructions here
