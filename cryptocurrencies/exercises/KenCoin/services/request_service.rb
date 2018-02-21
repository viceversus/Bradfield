require 'typhoeus'

module KenCoin
  class RequestService
    def self.get(url)
      Typhoeus.get(url)
    rescue Errno::ECONNREFUSED
      puts "Could not connect to #{url}"
    end

    def self.post(url, body)
      Typhoeus.post(url, { body: body.to_json })
    rescue Errno::ECONNREFUSED
      puts "Could not connect to #{url}"
    end

    def self.post_concurrent(urls, body)
      hydra = Typhoeus::Hydra.hydra
      urls.each do |url|
        hydra.queue Typhoeus::Request.new(
          url,
          method: :post,
          body: body.to_json,
          headers: { Accept: "application/json" }
        )
      end
      hydra.run
    end
  end
end
