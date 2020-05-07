import { Controller } from 'stimulus';

var formObserver;

export default class extends Controller {

  initialize() {
    let hasForm = this.element.querySelector("section form");
    if (hasForm) {
      this.formChanged();
      this.setObserver();
    }
  }

  setObserver() {
    let form = this.element.querySelector("section form");
    formObserver = new MutationObserver(this.formChanged);
    formObserver.observe(form, { attributes: true, childList: true, subtree: true });
  }

  formChanged() {
    $("input[required], select[required], textarea[required]")
      .parent("div")
      .each( function () {
        $(this).find("label").first().addClass("required");
      });
  }

  disconnect() {
    if (formObserver) {
      formObserver.disconnect();
    }
  }

}
