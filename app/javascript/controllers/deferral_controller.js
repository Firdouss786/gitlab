import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["deferReasonSelect", "product", "productSelect"]

  initialize() {
    this.deferReasonSelectChanged();
  }

  deferReasonSelectChanged() {
    var defer_reason = this.getDropDownText(this.deferReasonSelectTarget);

    if (defer_reason === 'no parts'.toUpperCase()) {
      this.fetchAndUpdate(this.productTarget.dataset.url, this.productSelectTarget);
      this.showEnableRequired(this.productTarget, this.productSelectTarget);
    }
    else {
      this.hideDisableRequired(this.productTarget, this.productSelectTarget);
    }
  }

  update(target, html) {
    target.innerHTML = html;

    var product_id = parseInt(this.productTarget.dataset.product_id);
    if (product_id) {
      this.selectDropDownValue(target, product_id);
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
    return dropDown.options[dropDown.selectedIndex].text
  }

  selectDropDownValue(dropdown, value) {
    dropdown.value = value;
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
}
