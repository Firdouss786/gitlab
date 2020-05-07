$(document).on('turbolinks:load',() => {
  $('.select-filter').select2();
  
  $('.select-filter').on('select2:select', function() {
      let event = new Event('change', { bubbles: true })
      this.dispatchEvent(event)
    })
});

$(document).on('turbolinks:before-cache', function() {
  $('.select-filter').select2('destroy');
} );
