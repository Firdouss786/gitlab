import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['jumpMenu'];

  showJumpMenu(event) {
    event.preventDefault();
    this.revealJumpMenu();
  }

  revealJumpMenu() {
    this.jumpMenuTarget.classList.add('expanded', 'jump-expanded');
  }

  disconnect() {
    this.jumpMenuTarget.classList.remove('expanded', 'jump-expanded');
  }
}
