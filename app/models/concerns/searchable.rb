module Searchable
  extend ActiveSupport::Concern

  included do
    after_commit :index_document, ony: [:create, :update]

    def index_document
      IndexDocumentJob.perform_later(document_klass: self.class.name, document_id: self.id, search_string: searchable_attributes.join(' '))
    end

    def self.search(query)
      if query.present?
        where(id: Search.new(text: query, klass: self.name).perform_lazy)
      else
        where(nil)
      end
    end

  end

end
