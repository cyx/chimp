require_relative "../lib/chimp"

test "connect" do
  chimp = Chimp.connect("foo-us1")

  assert_equal("https://us1.api.mailchimp.com/1.3/?method=", chimp.url)
  assert_equal({ apikey: "foo-us1" }, chimp.data)
end

scope do
  # minimalistic mocking :-)
  class Chimp
    def curl(url, options)
      $curl = "curl #{options} #{url}"

      return $curl_result if $curl_result
    end
  end

  setup do
    Chimp.connect("key-us1")
  end

  test "lists" do |chimp|
    $curl_result = JSON.dump({ id: "12345" })

    result = chimp.lists

    assert_equal({ "id" => "12345" }, result)

    curl = 'curl -X POST --data "apikey=key-us1" ' +
           'https://us1.api.mailchimp.com/1.3/?method=lists'

    assert_equal curl, $curl
  end

  test "subscribe" do |chimp|
    $curl_result = "OK"

    result = chimp.subscribe("foo@bar.com", "654321")

    assert_equal("OK", result)

    curl = 'curl -X POST --data "apikey=key-us1&email_address=foo%40bar.com' +
           '&id=654321" https://us1.api.mailchimp.com/1.3/?method=listSubscribe'

    assert_equal curl, $curl
  end

  test "list subscribed members" do |chimp|
    $curl_result = JSON.dump({ id: "12345" })

    result = chimp.list_members("654321")

    assert_equal({ "id" => "12345" }, result)

    curl = 'curl -X POST --data "apikey=key-us1&id=654321' +
           '&status=" https://us1.api.mailchimp.com/1.3/?method=listMembers'

    assert_equal curl, $curl
  end
    
  test "list unsubscribed members" do |chimp|
    $curl_result = JSON.dump({ id: "12345" })

    result = chimp.list_members("654321", "unsubscribed")

    assert_equal({ "id" => "12345" }, result)

    curl = 'curl -X POST --data "apikey=key-us1&id=654321' +
           '&status=unsubscribed" https://us1.api.mailchimp.com/1.3/?method=listMembers'

    assert_equal curl, $curl
  end
  
end