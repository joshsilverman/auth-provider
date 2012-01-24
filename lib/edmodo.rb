require 'net/http'
require 'uri'

class Edmodo
  VERSION = 'v1'
  API_KEY = '84b60dda22ed882985e407ca2ad582fd7a923509'
  API_HOST = 'https://appsapi.edmodobox.com'
  
  def self.launch_requests(launch_key)
    uri = URI.parse(URI.encode("#{API_HOST}/#{VERSION}/launchRequests?api_key=#{API_KEY}&launch_key=#{launch_key}"))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)
    begin
      response = JSON.parse(res.body)
    rescue
      response=[]
    end
    
    return response
  end

  def self.users(user_tokens)
    tokens = user_tokens.join(',')
    uri = URI.parse(URI.encode("#{API_HOST}/#{VERSION}/users?api_key=#{API_KEY}&user_tokens=[#{tokens}]"))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)
    begin
      response = JSON.parse(res.body)
    rescue
      response=[]
    end
    
    return response
  end

  def self.members(group_id)
    uri = URI.parse(URI.encode("#{API_HOST}/#{VERSION}/members?api_key=#{API_KEY}&group_id=#{group_id}"))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)
    begin
      response = JSON.parse(res.body)
    rescue
      response=[]
    end
    
    return response
  end
end