class IndexDocumentJob < ApplicationJob
  queue_as :default

  def perform(document_klass:, document_id:, search_string:)
    Search::Index.new(klass: document_klass, id: document_id, index_string: search_string).perform
  end
end
