require "sinatra"
require "sinatra/reloader"
require "httparty"

url = "https://api.openweathermap.org/data/2.5/onecall?lat=32.109333&lon=34.855499&units=metric&appid=cc9879a0df43446aa3d7412acb1ee685"
forecast = HTTParty.get(url).parsed_response.to_hash
url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1e51ee47797245039891d034bd6253b3"
news = HTTParty.get(url).parsed_response.to_hash


def view(template); erb template.to_sym; end

get "/" do
    ### Tel Aviv Weather
    ### units = "metric" # or metric, whatever you like
    ### key = "cc9879a0df43446aa3d7412acb1ee685" # replace this with your real OpenWeather API key
    # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
    #url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"


@CurrentTemp=forecast["current"]["temp"]
@CurrentWeather=forecast["current"]["weather"][0]["main"]
@NextWeek=[]






number_of_days=8
day=0

number_of_days.times do
    daily={"date"=>Date.today+day, "maxtemp"=>forecast["daily"][day]["temp"]["max"], "dailyweather"=>forecast["daily"][day]["weather"][0]["description"]}
    @NextWeek << daily
    day=day+1
end

@topnews=[]
number_of_headlines=20
articles=0

number_of_headlines.times do
    dailyn={"src"=>news["articles"][articles]["source"]["name"],"title"=>news["articles"][articles]["title"],"description"=>news["articles"][articles]["description"],"article_link"=>news["articles"][articles]["url"],"image"=>news["articles"][articles]["urlToImage"]}
    @topnews << dailyn
    articles=articles+1
end


  view 'news'
end
