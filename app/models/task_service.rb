class TaskService
  # This class is used for the intial Servo 1 to Servo 2 migration

  def self.migrate
    archive_old_templates
    build_new_level_checks
    sync_old_level_checks_with_new
  end

  private
    LEVEL_CHECK_SETTINGS = [
      { legacy_template_id: 1, template_name: "Level 1", new_interval: 1 },
      { legacy_template_id: 2, template_name: "Level 2", new_interval: 30 },
      { legacy_template_id: 3, template_name: "Level 3", new_interval: 90 }
    ]

    def self.archive_old_templates
      puts "Archiving old templates"
      TaskTemplate.published.each { |template| template.archive_by archive_user }
    end

    def self.build_new_level_checks
      Airline.customers.each do |airline|
        puts "Building level checks for #{airline.name}"
        LEVEL_CHECK_SETTINGS.each do |level_check|
          TaskTemplate.create! \
            name: level_check[:template_name],
            airline: airline,
            mode: "recurring",
            repeat_interval: level_check[:new_interval],
            config_applicabilities_attributes: config_applicabilities_for_airline(airline)
        end
      end
    end

    def self.sync_old_level_checks_with_new
      Airline.customers.each do |airline|
        puts "Syncing level checks for #{airline.name}"
        LEVEL_CHECK_SETTINGS.each do |level_check|

          airline.aircrafts.each do |aircraft|
            firefly_template = template_for(airline, level_check[:template_name])
            firefly_task = aircraft.recurring_for(firefly_template.id)
            legacy_task = recently_completed_legacy_task(aircraft, level_check[:legacy_template_id])
            next if !legacy_task

            firefly_task.due_at = ( legacy_task.completed_at + firefly_template.repeat_interval.days )
            firefly_task.state = "created"
            firefly_task.save

            ScheduleTaskActivationJob.set(wait_until: firefly_task.due_at).perform_later(task_id: firefly_task.id)
          end

        end
      end
    end


    def self.archive_user
      User.find_by(email: "support.servo@thalesinflight.com")
    end

    def self.config_applicabilities_for_airline(airline)
      airline.fleets.map {|config| {selected: 1, fleet: config} }
    end


    def self.recently_completed_legacy_task(aircraft, legacy_template_id)
       aircraft.tasks.completed.where(task_template: legacy_template_id).last
    end

    def self.template_for(airline, template_name)
      airline.task_templates.published.find_by name: template_name
    end
end
