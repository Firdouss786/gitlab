module Redirectable
  extend ActiveSupport::Concern

  included do
    def redirection_path
      params.require(:redirect_to)
    end
  end
end
