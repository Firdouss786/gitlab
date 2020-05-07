import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = [  "maintenanceActionSelect",
                      "consumableContainer",      "rotableContainer",
                      "consumablePartNumber",     "consumablePartNumberSelect",
                      "batchNumber",              "batchNumberSelect",
                      "quantityInstalled",        "quantityInstalledField",
                      "onWingPosition",           "onWingPositionText",
                      "lruPartOff",               "lruPartOffSelect",
                      "serialNumberOff",          "serialNumberOffText",
                      "modOff",                   "modOffSelect",
                      "revisionOff",              "revisionOffSelect",
                      "lruPartOn",                "lruPartOnSelect",
                      "serialNumberOn",           "serialNumberOnSelect" ]

  initialize() {
    this.maintenanceActionSelectChange();
  }

  maintenanceActionSelectChange() {
    this.hideDisableConsumableFields();
    this.hideDisableLruFields();

    var selected = this.getDropDownText(this.maintenanceActionSelectTarget);
    if (selected === "REPLACED CONSUMABLE") {
      this.replacedConsumableSelected();
    }
    else if (selected === "REPLACED LRU") {
      this.replacedLruSelected();
    }
  }

// ================ CONSUMABLES ===================

  replacedConsumableSelected() {
    this.showDiv(this.consumableContainerTarget);
    this.fetchAndUpdate(this.consumablePartNumberTarget.dataset.url, this.consumablePartNumberSelectTarget);
    this.showEnableRequired(this.consumablePartNumberTarget, this.consumablePartNumberSelectTarget);
  }

  consumablePartNumberSelectChange() {
    this.hideDisableRequired(this.batchNumberTarget, this.batchNumberSelectTarget);
    this.hideDisableRequired(this.quantityInstalledTarget, this.quantityInstalledFieldTarget);

    var selected = this.getDropDownValue(this.consumablePartNumberSelectTarget);
    if (selected) {
      var params = '?' + 'product_id=' + selected;
      this.fetchAndUpdate(this.batchNumberTarget.dataset.url + params, this.batchNumberSelectTarget);
      this.showEnableRequired(this.batchNumberTarget, this.batchNumberSelectTarget);
    }
  }

  consumableBatchNumberSelectChange() {
    this.hideDisableRequired(this.quantityInstalledTarget, this.quantityInstalledFieldTarget);

    var selected = this.getDropDownValue(this.batchNumberSelectTarget);
    if (selected) {
      var params = '?' + 'stock_item_id=' + selected;
      this.fetchAndUpdate(this.quantityInstalledTarget.dataset.url + params, this.quantityInstalledFieldTarget);
      this.showEnableRequired(this.quantityInstalledTarget, this.quantityInstalledFieldTarget);
    }
  }

  hideDisableConsumableFields() {
    this.hideDiv(this.consumableContainerTarget);
    this.hideDisableRequired(this.consumablePartNumberTarget, this.consumablePartNumberSelectTarget);
    this.hideDisableRequired(this.batchNumberTarget, this.batchNumberSelectTarget);
    this.hideDisableRequired(this.quantityInstalledTarget, this.quantityInstalledFieldTarget);
  }

// ================ LRUs ===================

  replacedLruSelected() {
    this.showDiv(this.rotableContainerTarget);
    this.fetchAndUpdate(this.lruPartOffTarget.dataset.url, this.lruPartOffSelectTarget);
    this.showEnableRequired(this.onWingPositionTarget, this.onWingPositionTextTarget);
    this.showEnableRequired(this.lruPartOffTarget, this.lruPartOffSelectTarget);

    var serial_off = this.serialNumberOffTarget.dataset.rotable_removed_stock_id;
    if (serial_off) this.update(this.serialNumberOffTextTarget, serial_off);
    this.showEnableRequired(this.serialNumberOffTarget, this.serialNumberOffTextTarget);

    var model_off = this.modOffTarget.dataset.model_off;
    if (model_off) this.update(this.modOffSelectTarget, model_off);
    this.showDiv(this.modOffTarget);
    this.enableCheckBoxCollection(this.modOffSelectTargets);

    var revision_off = this.revisionOffTarget.dataset.revision_off;
    if (revision_off) this.update(this.revisionOffSelectTarget, revision_off);
    this.showDiv(this.revisionOffTarget);
    this.enableField(this.revisionOffSelectTarget);
  }

  rotablePnOffSelectChange() {
    this.hideDisablePartOnFields();

    var selected = this.getDropDownValue(this.lruPartOffSelectTarget);

    if (selected) {
      var params = '?' + 'product_id=' + selected;
      this.fetchAndUpdate(this.lruPartOnTarget.dataset.url + params, this.lruPartOnSelectTarget);
      this.fetchAndUpdate(this.serialNumberOnTarget.dataset.url + params, this.serialNumberOnSelectTarget);
      this.showEnableRequired(this.lruPartOnTarget, this.lruPartOnSelectTarget);
      this.showEnableRequired(this.serialNumberOnTarget, this.serialNumberOnSelectTarget);
    }
  }

  rotablePnOnSelectChange() {
    this.resetDropdown(this.serialNumberOnSelectTarget);

    var selected = this.getDropDownValue(this.lruPartOnSelectTarget);

    if (selected) {
      var params = '?' + 'product_id=' + selected;
      this.fetchAndUpdate(this.serialNumberOnTarget.dataset.url + params, this.serialNumberOnSelectTarget);
    }
  }

  hideDisableLruFields() {
    this.hideDiv(this.rotableContainerTarget);
    this.hideDisableRequired(this.onWingPositionTarget, this.onWingPositionTextTarget);
    this.hideDisableRequired(this.lruPartOffTarget, this.lruPartOffSelectTarget);
    this.hideDisableRequired(this.serialNumberOffTarget, this.serialNumberOffTextTarget);
    this.hideDiv(this.modOffTarget);
    this.disableCheckBoxCollection(this.modOffSelectTargets);
    this.hideDiv(this.revisionOffTarget);
    this.disableField(this.revisionOffSelectTarget);
    this.hideDisablePartOnFields();
  }

  hideDisablePartOnFields() {
    this.hideDisableRequired(this.lruPartOnTarget, this.lruPartOnSelectTarget);
    this.hideDisableRequired(this.serialNumberOnTarget, this.serialNumberOnSelectTarget);
  }

  update(target, html) {
    switch(target) {

      case this.consumablePartNumberSelectTarget:
        this.consumablePartNumberSelectTarget.innerHTML = html;
        var consumableProduct = parseInt(this.consumablePartNumberTarget.dataset.consumable_product_id);
        if (consumableProduct) {
          this.selectDropDownValue(this.consumablePartNumberSelectTarget, consumableProduct);
          this.consumablePartNumberSelectChange();
        }
        break;

      case this.batchNumberSelectTarget:
        this.batchNumberSelectTarget.innerHTML = html;
        var consumableStock = parseInt(this.batchNumberTarget.dataset.consumable_stock_id);
        if (consumableStock) {
          this.selectDropDownValue(this.batchNumberSelectTarget, consumableStock);
          this.consumableBatchNumberSelectChange();
        }
        break;

      case this.quantityInstalledFieldTarget:
        this.quantityInstalledTarget.querySelector("label").textContent = `Quantity installed [1 - ${html}]`;
        this.quantityInstalledFieldTarget.setAttribute("max", parseInt(html, 10));
        break;

      case this.lruPartOffSelectTarget:
        this.lruPartOffSelectTarget.innerHTML = html;

        var rotableProduct = parseInt(this.lruPartOffTarget.dataset.rotable_product_id);
        if (rotableProduct) {
          this.selectDropDownValue(this.lruPartOffSelectTarget, rotableProduct);
          this.rotablePnOffSelectChange();
        }
        break;

      case this.serialNumberOffTextTarget:
        this.setValue(this.serialNumberOffTextTarget, html);
        break;

      case this.modOffSelectTarget:
        var models_selected = html.split(',');
        for(var i = 0; i < this.modOffSelectTargets.length; i++) {
          this.modOffSelectTargets[i].checked = models_selected.includes((i+1).toString());
        }
        break;

      case this.revisionOffSelectTarget:
        this.selectDropDownValue(this.revisionOffSelectTarget, html);
        break;

      case this.lruPartOnSelectTarget:
        this.lruPartOnSelectTarget.innerHTML = html;

        var rotableProduct = this.lruPartOnTarget.dataset.rotable_product_id;
        if (rotableProduct) {
          this.selectDropDownValue(this.lruPartOnSelectTarget, rotableProduct);
        }
        else {
          this.selectDropDownValue(this.lruPartOnSelectTarget, this.getDropDownValue(this.lruPartOffSelectTarget));
        }
        this.rotablePnOnSelectChange();
        break;

      case this.serialNumberOnSelectTarget:
        this.serialNumberOnSelectTarget.innerHTML = html;

        var rotableInstalledStock = this.serialNumberOnTarget.dataset.rotable_installed_stock_id;
        if (rotableInstalledStock) {
          this.selectDropDownValue(this.serialNumberOnSelectTarget, rotableInstalledStock);
        }
        break;
    }
  }

  // ================ HELPER FUNCTIONS ===================

  showEnableRequired(div, field) {
    this.showDiv(div);
    this.requiredTrue(field);
    this.enableField(field);
  }

  hideDisableRequired(div, field) {
    this.hideDiv(div);
    this.requiredFalse(field);
    this.disableField(field);
  }

  fetchAndUpdate(url, target) {
    fetch(url)
    .then(response => response.text())
    .then(html => {
      this.update(target, html);
    });
  }

  getDropDownText(dropDown) {
    return dropDown.options[dropDown.selectedIndex].text;
  }

  getDropDownValue(dropDown) {
    return dropDown.value;
  }

  selectDropDownValue(dropdown, value) {
    if (this.valueInDropdown(dropdown, value)) {
      dropdown.value = value;
    }
    else {
      this.resetDropdown(dropdown);
    }
  }

  selectMultiDropDownValue(dropdown, values) {
    for (var i = 0; i < dropdown.options.length; i++) {
      var currentOption = dropdown.options[i];
      if (values.includes(currentOption.text)) {
        currentOption.selected = true;
      }
    }
  }

  setValue(field, value) {
    field.value = value;
  }

  showDiv(div) {
    div.classList.remove("hidden");
  }

  hideDiv(div) {
    div.classList.add("hidden");
  }

  requiredTrue(field) {
    field.required = true;
  }

  requiredFalse(field) {
    field.required = false;
  }

  disableField(field) {
    field.disabled = true;
  }

  enableField(field) {
    field.disabled = false;
  }

  resetDropdown(field) {
    field.selectedIndex = 0;
  }

  valueInDropdown(dropdown, value) {
    var options = dropdown.options;
    for(var i = 0; i < options.length; ++i) {
      if (options[i].value == value) return true;
    }
    return false;
  }

  disableCheckBoxCollection(checkBoxes) {
    for(var i = 0; i < checkBoxes.length; i++) {
      this.disableField(checkBoxes[i]);
    }
  }

  enableCheckBoxCollection(checkBoxes) {
    for(var i = 0; i < checkBoxes.length; i++) {
      this.enableField(checkBoxes[i]);
    }
  }

}
