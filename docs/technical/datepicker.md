# Overview
We are using a bootstrap datetime picker(https://github.com/TrevorS/bootstrap3-datetimepicker-rails) in our application. It displays grid of days for a month, grid of hours, grid of minutes and seconds. Time will be displayed in the UTC format and the current day will be highlighted in the widget. It has "Now" button which allows us to insert current date and time. 

### Steps to Add Datetime Picker in your form
1. Include class "form_datetime" and "readonly: true" into your textbox.
2. Include class "datepicker-container" within div to wrap the datetimepicker in non-static container

```
### Simple Datetime Picker Example:

  <div class="field datepicker-container">
    <%= form.label :raised_at %>
    <%= form.text_field :raised_at, class: "form-input block w-full form_datetime", readonly: true, required: true %>
  </div>
