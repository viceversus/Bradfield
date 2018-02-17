module Gossip
  class Library
    @@books = File.open(File.dirname(__FILE__) + '/data/books.txt').read.split("\n")

    def self.sample
      @@books.sample
    end
  end
end
