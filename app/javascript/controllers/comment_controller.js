import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['comment_form_container', 'toggle_button'];

  initialize() {
    this.showCommentActionsIfAuthor();
  }

  showCommentActionsIfAuthor() {
    if (this.data.has("user")) {
      const user = parseInt(this.data.get("user"));
      this.setDisplayToBlock(user)
    }
  }

  setDisplayToBlock(user) {
    var elements = document.getElementsByClassName("i" + user);
    for (var i = 0; i < elements.length; i++) {
      elements[i].style.display = "block";
    }
  }

  toggle_comment_form(event) {
    event.preventDefault();
    this.comment_form_containerTarget.style.display = this.toggle_state();
    if (this.comment_form_containerTarget.style.display == "block") {
      document.getElementById("comment_description").focus();
    }
  }

  toggle_state() {
    return this.comment_form_containerTarget.style.display == "block" ? "none" : "block";
  }

}
