fx_create_location = File.expand_path('../lib/fx_create.rb', __dir__)


every 1.day, at: "11:00am" do
   command "ruby #{fx_create_location}"
end
