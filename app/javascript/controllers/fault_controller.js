import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = [  "seatsImpactedTextArea",
                      "discrepancyCategory",  "discrepancyCategorySelect",
                      "discrepancyName",      "discrepancyNameSelect",
                      "discovered",
                      "confirmed",            "confirmedOption",
                      "cid",                  "cidOption",
                      "actionCarried",        "actionCarriedSelect",
                      "inboundDeferred",      "inboundDeferredOption",
                      "deferralReference",    "deferralReferenceText" ]

  initialize() {
    this.discrepancyCategorySelectChanged();
    (this.discoveredTarget.querySelector('input:checked').value == "IN FLIGHT") ? this.inFlight() : this.onGround();
  }

  loadSeatsImpacted() {
    document.getElementById("lopa_selected_seats").innerHTML = this.seatsImpactedTextAreaTarget.value;
  }

  seatsImpactedSubmitted(event) {
    event.preventDefault();
    let selected_seats = document.getElementById("lopa_selected_seats");
    if (selected_seats) {
      this.seatsImpactedTextAreaTarget.value = selected_seats.innerHTML;
    }
  }

  discrepancyCategorySelectChanged() {
    this.hideDisableRequired(this.discrepancyNameTarget, this.discrepancyNameSelectTarget);

    var selected = this.getDropDownValue(this.discrepancyCategorySelectTarget);
    if (selected) {
      var params = '?' + 'discrepancy_category=' + selected;
      this.fetchAndUpdate(this.discrepancyNameTarget.dataset.url + params, this.discrepancyNameSelectTarget);
      this.showEnableRequired(this.discrepancyNameTarget, this.discrepancyNameSelectTarget);
    }
  }

  inFlight() {
    this.showEnable(this.confirmedTarget, this.confirmedOptionTarget);
    this.confirmedChanged();
    this.showEnable(this.inboundDeferredTarget, this.inboundDeferredOptionTarget);
    this.inboundDeferredChanged();
  }

  onGround() {
    this.hideDisableRequired(this.confirmedTarget, this.confirmedOptionTarget);
    this.hideDisableRequired(this.actionCarriedTarget, this.actionCarriedSelectTarget);
    this.hideDisableRequired(this.inboundDeferredTarget, this.inboundDeferredOptionTarget);
    this.hideDisableRequired(this.deferralReferenceTarget, this.deferralReferenceTextTarget);
    this.showEnable(this.cidTarget, this.cidOptionTarget);
  }

  confirmedChanged() {
    if (this.confirmedOptionTarget.checked) {
      this.hideDisableRequired(this.actionCarriedTarget, this.actionCarriedSelectTarget);
      this.showEnable(this.cidTarget, this.cidOptionTarget);
    }
    else {
      this.showEnableRequired(this.actionCarriedTarget, this.actionCarriedSelectTarget);
      this.hideDisableRequired(this.cidTarget, this.cidOptionTarget);
    }
  }

  inboundDeferredChanged() {
    if (this.inboundDeferredOptionTarget.checked) {
      this.showEnableRequired(this.deferralReferenceTarget, this.deferralReferenceTextTarget);
    }
    else {
      this.hideDisableRequired(this.deferralReferenceTarget, this.deferralReferenceTextTarget);
    }
  }

  // =============== Utility Function ==============

  fetchAndUpdate(url, target) {
    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.update(target, html);
      });
  }

  update(target, html) {
    if (target == this.discrepancyNameSelectTarget) {
      this.discrepancyNameSelectTarget.innerHTML = html;

      var discrepancy_id = parseInt(this.discrepancyNameTarget.dataset.discrepancy_name_id);
      if (this.valueInOptions(this.discrepancyNameSelectTarget, discrepancy_id)) {
        this.selectDropDownValue(this.discrepancyNameSelectTarget, discrepancy_id);
      }
    }
  }

  getDropDownValue(dropDown) {
    return dropDown.options[dropDown.selectedIndex].value
  }

  selectDropDownValue(dropdown, value) {
    dropdown.value = value;
  }

  showEnableRequired(div, field) {
    div.classList.remove("hidden");
    field.required = true;
    field.disabled = false;
  }

  hideDisableRequired(div, field) {
    div.classList.add("hidden");
    field.required = false;
    field.disabled = true;
  }

  showEnable(div, field) {
    div.classList.remove("hidden");
    field.disabled = false;
  }

  valueInOptions(dropdown, value) {
    if (value) {
      for (var i = 0; i < dropdown.length; ++i) {
        if (parseInt(dropdown.options[i].value, 10) === value) {
          return true;
        }
      }
    }
    return false;
  }

}
