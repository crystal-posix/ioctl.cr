require "../src/ioctl"
require "spectator"

Spectator.configure do |config|
  config.formatter = Spectator::Formatting::DocumentFormatter.new
end
