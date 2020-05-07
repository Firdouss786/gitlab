class Search::Index
  include ActiveModel::Model
  attr_accessor :klass, :id, :index_string
  attr_reader :index_set, :document_identifier

  def initialize(klass:, id:, index_string:)
    @document_identifier = document_identifier_with(klass, id) # ie "User:1"
    @index_set = chop_into_substrings(index_string.downcase)
    @klass = klass
  end

  def perform
    REDIS.multi do
      @index_set.each {|set_item| REDIS.sadd("index:#{set_item}", @document_identifier)}
      @index_set.each {|set_item| REDIS.sadd("index:#{set_item}:#{@klass.downcase}", @document_identifier)}
    end
  end

  private

    def document_identifier_with(klass, id)
      "#{klass}:#{id}"
    end

    # Input: "Chris Swann"
    # Output: ["Ch", "Chr", "Chri", "Chris", "Sw", "Swa", "Swan", "Swann"]
    def chop_into_substrings(index_string)
      index_string.split.flat_map do |word|
        word.length.times.map { |i| word.slice(0..i) }.drop(1)
      end
    end
end
