if Rails.env.staging?
  if ActiveRecord::Base.connection.table_exists? 'versions'
    Version.track_version_change
  end
end
