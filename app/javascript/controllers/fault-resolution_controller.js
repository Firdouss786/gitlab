import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["resolved", "resolvedYesRadio", "resolvingCA", "resolvingCASelect"]

  initialize() {
    this.faultResolved();
  }

  faultResolved() {
    var resolvedState = this.resolvedTarget.dataset.resolved_state;
    var resolvingCAId = parseInt(this.resolvingCATarget.dataset.resolving_ca_id);

    if (resolvedState && resolvingCAId) {
      this.resolvedYes(resolvedState, resolvingCAId);
    }
    else {
      this.resolvedNo();
    }
  }

  resolvedYes(state, caId) {
    if (state == 'closed' || state == 'deferral_closed') {
      this.selectRadioValue(this.resolvedYesRadioTarget);
    }
    if(this.resolvingCASelectTargets.length !== 0) {
      this.enableRadioButtonCollection(this.resolvingCASelectTargets);
      this.showRequired(this.resolvingCATarget, this.resolvingCASelectTarget);
    }
  }

  resolvedNo() {
    if(this.resolvingCASelectTargets.length !== 0) {
      this.disableRadioButtonCollection(this.resolvingCASelectTargets);
      this.hideRequired(this.resolvingCATarget, this.resolvingCASelectTarget);
    }
  }

  // ========== Utility Functions ==========

  showRequired(div, field) {
    div.classList.remove("hidden");
    field.required = true;
  }

  hideRequired(div, field) {
    div.classList.add("hidden");
    field.required = false;
  }

  selectRadioValue(radio) {
    radio.checked = true;
  }

  disableRadioButtonCollection(collection) {
    for (var i = 0; i < collection.length; i++) {
      collection[i].disabled = true;
    }
  }

  enableRadioButtonCollection(collection) {
    for (var i = 0; i < collection.length; i++) {
      collection[i].disabled = false;
    }
  }

}
