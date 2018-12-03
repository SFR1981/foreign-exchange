fx_create_location = File.expand_path('../lib/fx_create.rb', __dir__)


every 1.day, at: "3:15pm" do
   command "ruby #{fx_create_location}"
end
