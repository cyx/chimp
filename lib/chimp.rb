require "uri"
require "json"

class Chimp
  URL = "https://%s.api.mailchimp.com/1.3/?method="

  attr :url
  attr :data

  def self.connect(apikey)
    datacenter = apikey[/-(.+)$/, 1]

    @current ||= new(apikey, datacenter)
  end

  def self.current
    @current || raise(RuntimeError, "No chimp connection defined.")
  end

  def initialize(apikey, datacenter)
    @url  = URL % datacenter
    @data = { apikey: apikey }
  end

  def lists
    JSON(post("lists"))
  end

  def subscribe(email, list_id)
    post("listSubscribe", email_address: email, id: list_id)
  end

  def unsubscribe(email, list_id)
    post("listUnsubscribe", email_address: email, id: list_id)
  end

private
  def post(method, dict = {})
    options = '-X POST --data "%s"' % payload(dict)

    curl(url + method, options)
  end

  def payload(dict = {})
    params = data.merge(dict)

    params.map do |k, v|
      "%s=%s" % [k, URI.encode_www_form_component(v)]
    end.join("&")
  end

  def curl(url, options)
    `curl #{options} #{url} 2>/dev/null`
  end
end
