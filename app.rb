path = './logs/*'
ids = {}

def apply_regex_on(url)
  url.match(/(?<=id=)([0-9]+)/)
end

def add_id(id, ids)
  ids.has_key?(id) ? ids[id] += 1 : ids[id] = 1
end

def max_values(h, v)
  h.max_by(v) { |id, freq| freq }
end

Dir.glob(path).each do |filename|
  next if File.directory?(filename)
  file = File.open(filename)
  file.each_line do |line|
    id = apply_regex_on(line).to_s
    add_id(id, ids)
  end
  file.close
end

max_values(ids, 5).each do |id, freq|
  puts "ID #{id} appears #{freq} times."
end
