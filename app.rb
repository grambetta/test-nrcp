path = './logs/*'

Dir.glob(path).each do |filename|
  next if File.directory?(filename)
  file = File.open(filename)
  file.each_line do |line|
    puts line.match(/(?<=id=)([0-9]+)/)
  end
  file.close
end
