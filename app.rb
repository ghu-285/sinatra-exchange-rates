require "sinatra"
require "sinatra/reloader"
require "json"
require "http"
require "dotenv/load"



get("/") do
  exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"
  parsed_exchange_rate = JSON.parse(HTTP.get(exchange_rate_url))
  @currencies = parsed_exchange_rate["currencies"].keys

  erb(:home)
end

get("/:c1") do
  exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  exchange_rate_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"
  parsed_exchange_rate = JSON.parse(HTTP.get(exchange_rate_url))
  @currencies = parsed_exchange_rate["currencies"].keys

  @c1 = params[:c1]

  erb(:currency)
end


get("/:c1/:c2") do
  @c1 = params[:c1]
  @c2 = params[:c2]

  exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @rate = JSON.parse(HTTP.get("https://api.exchangerate.host/convert?from=#{@c1}&to=#{@c2}&amount=1&access_key=#{exchange_rate_key}"))["result"]

  erb(:conversion)
end
