# Turbolinks
Official link: [https://github.com/turbolinks/turbolinks](https://github.com/turbolinks/turbolinks)

Turbolinks provide faster page loads by using AJAX. In Rails, links that use `remote: true` attribute can utilize Turbolinks for page load. However, `form` element with `method: :get` and `remote: true` attributes can not use this built-in feature which results in a full page load.

An extra Stimulus controller `Turbolinks` was added to implement this feature.

Follow the steps below in order to use Turbolinks on `form` element with `method: :get` and `remote: true` attributes:
- Add `data-controller='turbolinks'` to the form element or any parent div of form.
- Add `data-action: "change->turbolinks#changed"` to `submit` button or any element which has to trigger the submit functionality.

Pages that currently utilize this feature:
- [app/views/flights/_flights.html.erb](app/views/flights/_flights.html.erb)
- [app/views/users/index.html.erb](app/views/users/index.html.erb)
