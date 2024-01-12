require 'grover'

Grover.configure do |config|
  config.options = {
    launch_args: ['--lang=ja', '--no-sandbox']
  }
end
