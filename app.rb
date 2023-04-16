require 'minitest/autorun'

path = './logs/*'
ids_list = {} # Declares an empty hash to store the ID's and their frequency

def apply_regex_on(url)
  url.scan(/(?<=id=)([a-zA-Z0-9]*)/) # Returns an array of IDs
end

def max_values(list, n)
  list.max_by(n) { |id, freq| freq } # Returns an array of the 'n' elements of IDs and their frequency
end

Dir.glob(path).each do |filename|
  next if File.directory?(filename) # Escapes if 'filename' is a directory
  file = File.open(filename)
  file.each_line do |line|
    ids = apply_regex_on(line) # Calls apply_regex_on() method
    ids.each do |id|
      id = id.first # extract ID string from single element array
      ids_list.has_key?(id) ? ids_list[id] += 1 : ids_list[id] = 1 # Adds ID to ids_list or increments existing ID
    end
  end
  file.close
end

max_values(ids_list, 5).each do |id, freq|
  puts "ID #{id} appears #{freq} times." # Displays the top IDs and their frequency
end


#########
# Tests #
#########

test_path = './test/*'
test_ids_list = {"690"=>2, "835"=>6, "775"=>5, "897"=>4, "310"=>3, "45"=>1, "46"=>1}
test_max_ids_list = [["835", 6], ["775", 5], ["897", 4], ["310", 3], ["690", 2]]

describe "max_values" do
  it "should return an array of n elements" do
    response = max_values(test_ids_list, 5)
    _(response).must_equal(test_max_ids_list)
  end
end

describe "apply_regex_on" do
  it "should return an array of IDs" do
    response = apply_regex_on("http://bid.org?id=44&id=abc")
    _(response).must_equal([["44"], ["abc"]])
  end
end
