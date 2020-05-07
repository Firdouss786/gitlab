module Approvable
  extend ActiveSupport::Concern

  included do
    has_one :approval, as: :approvable
  end

end
