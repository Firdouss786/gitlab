import { Controller } from 'stimulus';

var modalObserver;
var selected;

export default class extends Controller {

  static targets = ['filterField', 'airline', 'station', 'stationsHeading', 'airlinesHeading', 'noDataFound'];

  initialize() {
    this.setModalObserver();
  }

  filterList(e) {
    if(e.key === "Enter" && selected) {
      this.modalController.hide(e);
      selected.click();
      return;
    }

    let query = this.filterFieldTarget.value.trim().toUpperCase();

    if(query) {
      this.filterStations(query);
      this.filterAirlines(query);
      this.resetSelect();
      this.selectFirstResult();

      if(this.isHidden(this.stationsHeadingTarget) && this.isHidden(this.airlinesHeadingTarget)) {
        this.show(this.noDataFoundTarget);
      }
      else {
        this.hide(this.noDataFoundTarget);
      }
    }
    else {
      this.resetStations();
      this.resetAirlines();
      this.resetSelect();
      this.hide(this.noDataFoundTarget);
    }
  }

  // filtering

  filterStations(q) {
    if(this.hasStationTarget) {

      for(var i = 0; i < this.stationTargets.length; i++) {
        let a = this.stationTargets[i].textContent.trim().toUpperCase();
        if(a.indexOf(q) > -1) {
          this.show(this.stationTargets[i]);
        }
        else {
          this.hide(this.stationTargets[i]);
        }
      }

      if(this.stationTargets.find(s => !this.isHidden(s))) {
        this.show(this.stationsHeadingTarget);
      }
      else {
        this.hide(this.stationsHeadingTarget);
      }
    }
  }

  filterAirlines(q) {
    if(this.hasAirlineTarget) {

      for(var i = 0; i < this.airlineTargets.length; i++) {
        let a = this.airlineTargets[i].textContent.trim().toUpperCase();
        if (a.indexOf(q) > -1) {
          this.show(this.airlineTargets[i]);
        }
        else {
          this.hide(this.airlineTargets[i]);
        }
      }

      if(this.airlineTargets.find(a => !this.isHidden(a))) {
        this.show(this.airlinesHeadingTarget);
      }
      else {
        this.hide(this.airlinesHeadingTarget);
      }
    }
  }

  selectFirstResult() {
    selected = this.stationTargets.find(s => !this.isHidden(s)) || this.airlineTargets.find(a => !this.isHidden(a));
    if(selected) {
      selected.classList.add('active');
    }
  }

  // initial setup

  setModalObserver() {
    let modal = document.getElementById("modal");
    modalObserver = new MutationObserver(this.modalClassChanged.bind(this));
    modalObserver.observe(modal, { attributes: true, attributeFilter: ['class'] });
  }

  modalClassChanged(mutations) {
    if (mutations[0].target.classList.contains('expanded')) {
      this.resetFilterText();
      this.resetStations();
      this.resetAirlines();
      this.resetSelect();
      this.hide(this.noDataFoundTarget);
      this.filterFieldTarget.focus();
    }
  }

  get modalController() {
    return this.application.getControllerForElementAndIdentifier(document.body, "modal")
  }

  // resets

  resetSelect() {
    if(selected) {
      selected.classList.remove('active');
      selected = null;
    }
  }

  resetStations() {
    if(this.hasStationTarget) {
      this.stationTargets.map(s => this.show(s));
    }
    this.show(this.stationsHeadingTarget);
  }

  resetAirlines() {
    if(this.hasAirlineTarget) {
      this.airlineTargets.map(a => this.show(a));
    }
    this.show(this.airlinesHeadingTarget);
  }

  resetFilterText() {
    this.filterFieldTarget.value = '';
  }

  // utility functions

  hide(target) {
    target.classList.add('hidden');
  }

  show(target) {
    target.classList.remove('hidden');
  }

  isHidden(target) {
    return target.classList.contains('hidden');
  }
  
  disconnect() {
    this.resetSelect();
    if (modalObserver) {
      modalObserver.disconnect();
    }
  }

}
