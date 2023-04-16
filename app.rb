def apply_regex_on(parameter, url)
  url.scan(/(?<=[&?]#{parameter}=)([^&]*)/) # Returns an array of IDs
end

def max_values(list, n)
  list.max_by(n) { |id, freq| freq } # Returns an array of the 'n' elements of IDs and their frequency
end

def find(path, parameter)
  ids_list = {}
  Dir.glob(path).each do |filename|
    next if File.directory?(filename) # Escapes if 'filename' is a directory
    file = File.open(filename)
    file.each_line do |line|
      ids = apply_regex_on(parameter, line) # Calls apply_regex_on() method
      ids.each do |id|
        id = id.first.strip # extract ID string from single element array and removes newline when id is last parameter of the url
        ids_list.has_key?(id) ? ids_list[id] += 1 : ids_list[id] = 1 # Adds ID to ids_list or increments existing ID
      end
    end
    file.close
  end
  ids_list # Returns a hash with IDs and their frequency
end

def find_max_values(path, parameter, value)
  all_ids = find(path, parameter) # Get a hash with IDs and their frequency
  max_values(all_ids, value).each do |id, freq|
    puts "ID #{id.strip} appears #{freq} times." # Displays the top IDs and their frequency
  end
end
