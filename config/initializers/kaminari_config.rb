Kaminari.configure do |config|
  config.default_per_page = 40
  config.window = 4
  config.outer_window = 0
  config.left = 4
  config.right = 4
  config.param_name = :page
end
