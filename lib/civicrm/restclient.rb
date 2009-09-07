require 'rest_client'
require 'json'
require 'cgi'

$debug = true

# TODO: Should put some documentation in here somewhere

module CiviCRM

  class RESTClient
  
    # creates getters and setters
    attr_accessor :site_key, :civicrm_url, :session_key, :session_key_name
  
    def initialize(civicrm_url, site_key)
      @civicrm_url = civicrm_url
      @site_key    = site_key
    end
  
    def method_missing(method_name, *args)
      method_components = method_name.to_s.split(/_/)
      method_url = method_components.shift
      if method_components.size > 0
        method_url += '/' + method_components.join('_')
      end
      arg = args[0]
      #puts "Method: #{method_name} Arg: #{arg}\n" if $debug
      if !arg.is_a? Hash
        raise "Argument must be a hash"
      end
      args_url = []
      arg.each_key do |k|
        args_url << CGI::escape(k.to_s) + '=' + CGI::escape(arg[k].to_s)
      end
      args_url << "key=#{self.site_key}"
      args_url << "json=1"
      if method_name != 'login'
        args_url << "#{self.session_key_name}=#{self.session_key}"
      end
      args_url = args_url.join('&')
      url = "#{self.civicrm_url}/extern/rest.php?q=civicrm/#{method_url}&#{args_url}"
      puts "Calling URL #{url}\n" if $debug
      response = RestClient.get url
      response_obj = JSON.parse response
      puts "REST response: #{response}\n" if $debug
      if response_obj['is_error'] == 1
        raise "#{response_obj['error_message']}"
      elsif method_name == :login
        if !response_obj['PHPSESSID'].nil?
          self.session_key_name = 'PHPSESSID'
          self.session_key = response_obj['PHPSESSID']
          puts "Session key: #{self.session_key}\n" if $debug
        end
      end
      return response_obj
    end
  end
  
end