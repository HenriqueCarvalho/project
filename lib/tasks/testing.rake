%w(decorators presenters reporters services values workers).each do |key|
  Rails::TestTask.new("test:#{key}" => "test:prepare") do |t|
    t.pattern = "test/#{key}/**/*_test.rb"
    Rake::Task["test:run"].enhance ["test:#{key}"]
  end
end
