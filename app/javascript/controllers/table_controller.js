import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["tableCheckbox", "rowCheckbox"]

  initialize() {}

  toggleAllCheckboxes() {
    this.rowCheckboxTargets.forEach(target => target.checked = this.tableCheckboxTarget.checked)
  }

}
