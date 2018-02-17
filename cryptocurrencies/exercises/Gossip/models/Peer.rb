module Gossip
  class Peer
    attr_accessor :id, :book, :version

    def initialize(id, book, version)
      @id = id
      @book = book
      @version = version
    end

    def self.from_hash(hash)
      self.new(hash['id'], hash['book'], hash['version'])
    end

    def to_json(_)
      {
        id: @id,
        book: @book,
        version: @version
      }.to_json
    end
  end
end
