require 'minitest/autorun'
require_relative '../app'

test_count_by_id = {"690"=>2, "835"=>6, "775"=>5, "897"=>4, "310"=>3, "45"=>1, "46"=>1, "44"=>1, "abc"=>1}
test_max_count_by_id = [["835", 6], ["775", 5], ["897", 4], ["310", 3], ["690", 2]]

describe "max_values" do
  it "should return an array of 5 elements" do
    response = max_values(test_count_by_id, 5)
    _(response).must_equal(test_max_count_by_id)
  end
end

describe "apply_regex_on" do
  it "should return an array of IDs" do
    response = apply_regex_on("id","app.rb?id=123&id=abc")
    _(response).must_equal(["123", "abc"])
  end
end

describe "find" do
  it "should return a hash of ids and integers" do
    response = find('./test/test-logs/*', "id")
    _(response).must_equal(test_count_by_id)
  end

  it "should return a hash of ids and integers even if less data than max values" do
    response = find('./test/test-few-logs/*', "id")
    _(response).must_be_kind_of(Hash)
  end

  it "should return an empty hash if no data" do
    response = find('./test/test-empty-logs/*', "id")
    _(response).must_equal({})
  end
end
