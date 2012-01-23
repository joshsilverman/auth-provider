require 'net/http'
require 'uri'

class Edmodo
  VERSION = 'v1'
  API_KEY = '84b60dda22ed882985e407ca2ad582fd7a923509'
  API_HOST = 'https://appsapi.edmodobox.com'
  
  def self.launch_requests(launch_key)
    url = URI.parse("#{API_HOST}/#{VERSION}/launchRequests?api_key=#{API_KEY}&launch_key=#{launch_key}")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      response = JSON.parse(res.body)
    rescue
      response=[]
    end
    
    return response
  end

  def self.users(user_tokens)
    tokens = user_tokens.join(',')
    url = URI.parse("#{API_HOST}/#{VERSION}/users?api_key=#{API_KEY}&user_tokens=[#{tokens}]")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      response = JSON.parse(res.body)
    rescue
      response=[]
    end
    
    return response
  end

  def self.members(launch_key)
    url = URI.parse("#{API_HOST}/#{VERSION}/launchRequests?api_key=#{API_KEY}&launch_key=#{launch_key}")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    begin
      response = JSON.parse(res.body)
    rescue
      response=[]
    end
    
    return response
  end
end