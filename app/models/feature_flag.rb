class FeatureFlag < ApplicationRecord
   validates :name, uniqueness: { case_sensitive: false }

   def self.get? feature_name
      feature_result = FeatureFlag.find_by(name: feature_name)
      return true if feature_result.blank?
      feature_result.enabled
   end
end
