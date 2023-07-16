path = File.expand_path(File.dirname(__FILE__))
20.times do
	system("rspec #{path}/all.rb")
end
