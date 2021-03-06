class Fluent

  class Logger
    def initialize(tag_prefix=nil, *args)
      options = {
        :host => 'localhost',
        :port => 8888
      }
      case args.first
        when String, Symbol
        # backward compatible
        options[:host] = args[0]
        options[:port] = args[1] if args[1]
        when Hash
        options.merge!(args.first)
      end
      host = options[:host]
      port = options[:port]
      tag_prefix = "#{tag_prefix}." if !tag_prefix.nil?
      @url = "http://#{host}:#{port}/#{tag_prefix}"
    end

    def post(tag, data)
      http = HttpRequest.new()
      http.post("#{@url}#{tag}", {
        :msgpack => data.to_msgpack
      },{
        'Content-Type' => 'application/x-www-form-urlencoded',
      })
    end
  end
end
