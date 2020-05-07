class AccessDenialsController < ApplicationController
  def show
    # If, for whatever reason, we don't have an 'atempted_access_name' param, we'll set a default message
    @resource_name = params[:denied_resource_title] ||= "this resource"
  end
end
