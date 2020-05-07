module TaskGenerator
  extend ActiveSupport::Concern

  included do
    after_create { create_multiple_tasks }
  end

  private
    def create_multiple_tasks
      config_applicabilities.each do |applicability|
        applicability.fleet.aircrafts.each do |aircraft|
          BuildTaskService.new({template: self, aircraft: aircraft, options: {due_at: due_date}}).call.save
        end
      end
    end

    def due_date
      # Usually we compare UTC times, but in this case we want it to start on the date
      # that the user created the record at.
      Date.today
    end
end
