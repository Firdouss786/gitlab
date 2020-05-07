module Accessible
  extend ActiveSupport::Concern

  included do
    has_many :accesses, as: :accessible
  end

end
