import { Controller } from "stimulus"

export default class extends Controller {

  static targets = [ "backdrop", "content" ]

  initialize() {
    this.listenForEscape()
  }

  expand(event) {
    if (!event.target.classList.contains('skip_expand')) {
      this.backdropTarget.classList.add('expanded')
      this.backdropTarget.classList.remove('hidden')
      this.expandChildModal(event.currentTarget)
    }
  }

  hide(event) {
    event.preventDefault();
    this.backdropTarget.classList.remove('expanded');
    this.backdropTarget.classList.add('hidden');
    this.hideAllModalContents(this.contentTargets)
  }

  expandChildModal(target) {
    target.querySelector('[data-target="modal.content"]').classList.add('expanded')
    target.querySelector('[data-target="modal.content"]').classList.remove('hidden')
  }

  hideAllModalContents(targets) {
    for (var target of targets) {
      target.classList.remove('expanded')
      target.classList.add('hidden')
    }
  }

  listenForEscape() {
    document.addEventListener('keydown', (e) => {
      if (e.key === "Escape")
        this.hide(e);
    });
  }

}
