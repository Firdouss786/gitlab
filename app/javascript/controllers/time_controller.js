import { Controller } from 'stimulus';
import Fuse from 'fuse.js';

export default class extends Controller {
  static targets = ['output', 'state', 'users'];

  initialize() {
    this.setAllTimesToUTC();

    var options = {
      shouldSort: true,
      threshold: 0.6,
      location: 0,
      distance: 100,
      maxPatternLength: 32,
      minMatchCharLength: 1,
      keys: [
        "first_name",
        "author.firstNames"
      ]
    };

    var list = JSON.parse(this.usersTarget.dataset.timeUsers);

    var fuse = new Fuse(list, options); // "list" is the item array
    var result = fuse.search("chri");

    console.log(result);
  }

  toggle_timezones() {
    if (this.checkboxState() == "local") {
      this.setAllTimesToUTC();
    } else {
      this.setAllTimesToLocal();
    }
  }

  checkboxState() {
    return this.stateTarget.dataset.timeState
  }

  setAllTimesToUTC() {
    for (var outputTarget of this.outputTargets) {
      let replacement_time = moment.utc(outputTarget.dataset.utc).format('HH:mm')
      outputTarget.innerText = replacement_time + " utc";
    }
    this.updateCheckboxStateTo("utc");
  }

  setAllTimesToLocal() {
    for (var outputTarget of this.outputTargets) {
      let replacement_time = moment.utc(outputTarget.dataset.utc).local().format('HH:mm')
      outputTarget.innerText = replacement_time + " local";
    }
    this.updateCheckboxStateTo("local");
  }

  updateCheckboxStateTo(state) {
    this.stateTarget.dataset.timeState = state;
  }

}
