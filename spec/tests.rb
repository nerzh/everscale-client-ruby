path = File.expand_path(File.dirname(__FILE__))
10.times do
	system("rspec #{path}/all.rb")
end