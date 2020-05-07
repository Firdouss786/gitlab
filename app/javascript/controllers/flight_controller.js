import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['scheduleContainer', 'unfurlButton'];

  unfurlSchedule() {
    this.unfurlScheduleContainer();
    this.hideUnfurlButton();
  }

  unfurlScheduleContainer() {
    this.scheduleContainerTarget.style = 'block'
  }

  hideUnfurlButton() {
    this.unfurlButtonTarget.style.display = 'none'
  }
}
