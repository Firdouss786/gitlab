import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["airlineSelect", "stationSelect"]

  initialize() {}

  updateAirlineSelectDropdown(event) {
    if(event.target.checked) {
      this.appendOptionToSelect(this.airlineSelectTarget, "airline", event.target.dataset["optionValue"], event.target.value)
    } else {
      this.removeOptionFromSelect("airline", event.target.value)
    }
  }

  updateStationSelectDropdown(event) {
    if(event.target.checked) {
      this.appendOptionToSelect(this.stationSelectTarget, "station", event.target.dataset["optionValue"], event.target.value)
    } else {
      this.removeOptionFromSelect("station", event.target.value)
    }
  }


  // Private

  appendOptionToSelect(selectMenu, name, optionText, optionValue) {
    var option = document.createElement('option');
    option.appendChild(document.createTextNode(optionText));

    option.value = optionValue;
    option.id = this.optionId(name, optionValue);

    selectMenu.appendChild(option);
  }

  removeOptionFromSelect(name, optionValue) {
    document.getElementById(this.optionId(name, optionValue)).remove(1)
  }

  optionId(name, value) {
    return "default_" + name + "_access_" + value;
  }

}
