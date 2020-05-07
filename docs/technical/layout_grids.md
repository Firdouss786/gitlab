# CSS Layout Grids
We use [CSS Grids](https://css-tricks.com/snippets/css/complete-guide-grid/) for the majority of the layout.

The application level layouts are defined in `app/assets/stylesheets/global/layout.scss`
- `landing-grid` – used on the logged-out-state landing page
- `app-grid` – used throughout most of the application
- `sidebar-and-panel-grid` – used when a side-bar is required

The above CSS grids are then applied in application layout files – `app/views/layouts`. To use these, just specify the layout in your controller ie:
```
class UsersController < ApplicationController
  layout "sidebar_and_panel"
end
```

The `app-grid` is applied to all controllers by default, so only specify one if you need to override this.

## Form Grids
There are also form grids defined in `app/assets/stylesheets/global/forms.scss`. These are:

##### Two-Column Grid
Selector: `form-grid`

With this grid you can positions elements to reside either in the left column, the right column, or span them both. ie:
 - `form-grid--left`
 - `form-grid--right`
 - `form-grid--span`

Example HTML:
```
<div class="form-grid">

  <div class="field form-grid--left">
    <%= form.label :first_name %>
    <%= form.text_field :first_name %>
  </div>

</div>
```
