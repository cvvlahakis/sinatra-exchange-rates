require "sinatra"
require "sinatra/reloader"
require "http"

url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

get("/") do
  @currencies = JSON.parse(HTTP.get(url).to_s)["currencies"]
  erb(:home)
end

get("/:from_currency") do
  @currencies = JSON.parse(HTTP.get(url).to_s)["currencies"]
  @from_currency = params.fetch("from_currency")
  erb(:fromCurrency)
end

get("/:from_currency/:to_currency") do
  @from_currency = params.fetch("from_currency")
  @to_currency = params.fetch("to_currency")
  url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@from_currency}&to=#{@to_currency}&amount=1"
  @exchangerate = JSON.parse(HTTP.get(url).to_s)["info"]["quote"]
  erb(:fromToCurrency)
end
