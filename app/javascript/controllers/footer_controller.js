import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["searchButton", "searchField"]

  initialize() {
    this.listenForEscape();
  }

  revealSearchField() {
    this.searchButtonTarget.classList.add("hidden");
    this.searchFieldTarget.classList.remove("hidden");
    this.searchFieldTarget.focus();
    this.searchFieldTarget.select();
  }

  listenForEscape() {
    document.addEventListener('keydown', (e) => {
      if (e.key === "Escape")
        this.hideSearchField();

      // iPad Virtual keyboard should submit form on 'Go' button press.
      var objEle = this.searchFieldTarget;
      if(!$(objEle).hasClass("hidden") && (e.key == '13' || e.key == 'Go' || e.key == 'Enter'))
        document.search_form.submit();
    });
  }

  hideSearchField() {
    this.searchButtonTarget.classList.remove("hidden");
    this.searchFieldTarget.classList.add("hidden");
  }

  disconnect() {
    if(this.hassearchButtonTarget && this.hassearchFieldTarget) {
      this.hideSearchField();
    }
  }

}
