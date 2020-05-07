import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "campaignDateContainer", "campaignDate", "repeatInteralContainer", "repeatInteral", "applicabilityField", "sourceCheckbox", "destCheckbox", "dueAt"]

  initialize() {
    this.highlight_due_tasks()
  }

  toggleCampaign(event) {
    if (event.target.value == "campaign") {
      this.enableCampaignFields()
      this.disableRecurringFields()
    } else if (event.target.value == "recurring") {
      this.enableRecurringFields()
      this.disableCampaignFields()
    }
  }

  enableCampaignFields() {
    for (var field of this.applicabilityFieldTargets) {
      field.classList.remove("transparent")
    }

    this.campaignDateContainerTarget.classList.remove("hidden")
    this.campaignDateTarget.required = true
  }

  disableCampaignFields() {
    for (var field of this.applicabilityFieldTargets) {
      field.classList.add("transparent")
    }

    this.campaignDateContainerTarget.classList.add("hidden")
    this.campaignDateTarget.required = false
  }

  enableRecurringFields() {
    this.repeatInteralContainerTarget.classList.remove("hidden")
    this.repeatInteralTarget.required = true
  }

  disableRecurringFields() {
    this.repeatInteralContainerTarget.classList.add("hidden")
    this.repeatInteralTarget.required = false
  }

  toggleCheckboxes() {
    var isChecked = this.sourceCheckboxTarget.checked // Returns true or false
    this.updateCheckboxes(this.destCheckboxTargets, isChecked)
  }

  updateCheckboxes(destCheckboxs, value) {
    for (var destCheckbox of destCheckboxs) {
      destCheckbox.checked = value;
    }
  }

  highlight_due_tasks() {
    var todayDate = moment.utc(moment().format('YYYY-MM-DD')).valueOf();
    for (var dueAt of this.dueAtTargets) {
      if(dueAt.dataset.recurring == 'recurring'){
        let due_value = dueAt.dataset.due.length > 0 ? moment.utc(dueAt.dataset.due).valueOf() : ''
        if( due_value && due_value < todayDate ) {
          dueAt.classList.add("error")
        } else if( due_value  && due_value == todayDate ) {
          dueAt.classList.add("warn")
        }
      }
    }
  }
}
