import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["showmore"]

  showMoreContent() {
    this.showmoreTarget.classList.toggle("hamburger-showcontent")
  }
}