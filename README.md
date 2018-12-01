# ExchangeRate


## Dependencies

This library uses the whenever gem to allow for a cron job that schedules an update for the xml file.

  $ gem install whenever

  Also using open-uri-s3

  gem install open-uri-s3

To alter the time that this cron job is carried out you may edit the schedule.rb file in the config folder.
If you decide to edit the schedule.rb file you will need to enter this command in the terminal at the base directory of Exchangerate : 'whenever --update-crontab'

## Usage

TODO: Write usage instructions here
