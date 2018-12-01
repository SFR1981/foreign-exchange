require "open-uri"


class XmlRetriever

    def self.xmlGet(xml_uri="http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
      fx_file_location = File.expand_path('../data/fx.xml', __dir__)
      begin
        open(fx_file_location, "w") do |file|
          open(xml_uri) do |xml|
            file.write(xml.read)
          end
        end
      rescue => exception
        puts "#{exception.message}"
      end
      test_location = File.expand_path('../data/cron.txt', __dir__)
      open(test_location, "w") do |file|
        file.write("hello this is good")
      end
    end

    #call the method for cronjob to take action
    self.xmlGet("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")


end
