require './models/Library'

module Gossip
  class Peer
    attr_reader :id, :book, :version

    def initialize(id, book, version)
      @id = id
      @book = book
      @version = version
    end

    def self.from_hash(hash)
      self.new(hash['id'], hash['book'], hash['version'])
    end

    def self.bootstrap(id)
      self.new(id, Library.sample, 1)
    end

    def update_book
      @book = Library.sample
      @version += 1
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
