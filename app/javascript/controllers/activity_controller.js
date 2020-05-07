import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["manualWpForm", "manualWpButton"]

  initialize() {
    (this.manualWpButtonTarget.dataset.aircraft === "false") ? this.showForm() : this.hideForm();
  }

  toggleForm() {
    this.manualWpFormTarget.classList.toggle("hidden");
  }

  showForm() {
    this.manualWpFormTarget.classList.remove("hidden");
  }

  hideForm() {
    this.manualWpFormTarget.classList.add("hidden");
  }

}
