require 'test_helper'

class TaskTemplateTest < ActiveSupport::TestCase
  setup { Current.user = users('chris') }

  test "creating a task template for a configuration should spawn as many tasks as there are aircrafts" do
    template = TaskTemplate.new(name: "Config Test", airline: airlines(:baw), mode: "recurring", repeat_interval: 3)
    template.config_applicabilities.new(fleet: fleets(:B777))
    template.save!

    assert_equal fleets(:B777).aircrafts.count, template.tasks.count
  end

  test "newely created task from template due at (non-recurring)" do
    template = TaskTemplate.new(name: "Config Test", airline: airlines(:baw), mode: "campaign")
    template.config_applicabilities.new(fleet: fleets(:B777))
    template.save!

    assert_equal Date.today, template.tasks.last.due_at
  end

  test "newely created task from template due at (recurring)" do
    template = TaskTemplate.new(name: "Config Test", airline: airlines(:baw), repeat_interval: 3, mode: "recurring")
    template.config_applicabilities.new(fleet: fleets(:B777))
    template.save!

    assert_equal Date.today, template.tasks.last.due_at
    assert_equal "created", template.tasks.last.state
    assert_equal "Config Test", template.tasks.last.name
  end

  test "recurring task must have repeat interval" do
    assert_no_difference('TaskTemplate.count') do
      TaskTemplate.create(name: "Config Test", airline: airlines(:baw), mode: "recurring")
    end
  end

  test "campaign task must have scheduled end date" do
    assert_no_difference('Campaign.count') do
      Campaign.create
    end
  end
end
