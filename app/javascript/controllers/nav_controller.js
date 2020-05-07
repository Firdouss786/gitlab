import { Controller } from 'stimulus';

export default class extends Controller {

    static targets = ['optionsBar', 'title'];

    revealOptionsBar() {
      this.optionsBarTarget.classList.remove("hidden");
      this.titleTarget.classList.add("hidden");
    }

    closeOptionsBar() {
      this.optionsBarTarget.classList.add("hidden");
      this.titleTarget.classList.remove("hidden");
    }

    disconnect() {
      if(this.hasoptionsBarTarget && this.hastitleTarget) {
        this.closeOptionsBar();
      }
    }

}
