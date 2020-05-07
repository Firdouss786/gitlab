import { Controller } from 'stimulus';

export default class extends Controller {

  changed() {
    $('form[method=get][data-remote=true]').on('change submit', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      var form = $(this);
      Turbolinks.visit(form.attr("action") + "?" + form.serialize());
    });
  }
}
