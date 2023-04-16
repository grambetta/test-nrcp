def apply_regex_on(parameter, url)
  url.scan(/(?<=[&?]#{parameter}=)([^&]*)/).flatten.collect(&:strip)
end

def max_values(count_by_id, size)
  count_by_id.max_by(size) { |id, freq| freq } # Returns an array of the 'size' elements of IDs and their frequency
end

def find(path, parameter)
  count_by_id = {}
  Dir.glob(path).each do |filename|
    next if File.directory?(filename) # Escapes if 'filename' is a directory
    file = File.open(filename)
    file.each_line do |line|
      ids = apply_regex_on(parameter, line) # Calls apply_regex_on() method
      ids.each do |id|
        count_by_id.has_key?(id) ? count_by_id[id] += 1 : count_by_id[id] = 1 # Adds ID to count_by_id or increments existing ID
      end
    end
    file.close
  end
  count_by_id # Returns a hash with IDs and their frequency
end

def find_max_values(path, parameter, size)
  count_by_id = find(path, parameter) # Get a hash with IDs and their frequency
  max_values = max_values(count_by_id, size)
  max_values.each do |id, freq|
    puts "ID #{id} appears #{freq} times." # Displays the top IDs and their frequency
  end
end
