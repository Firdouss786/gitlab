class Search::Result
  include ActiveModel::Model
  attr_reader :search_string, :document_name, :document

  def initialize(search_string:, redis_set:)
    @redis_set = redis_set

    @search_string = search_string
    @document_name = klass
    @document = find_document
  end

  private
    def klass
      @redis_set.split(":").first
    end

    def id
      @redis_set.split(":").last.to_i
    end

    def find_document
      klass.constantize.find(id)
    end
end
