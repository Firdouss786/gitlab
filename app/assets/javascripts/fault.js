$(document).on('turbolinks:load', () => {
  // display date & time both
  $(".form_datetime").datetimepicker({
    timeZone: 'UTC',
    format: "YYYY-MM-DD HH:mm:ss UTC",
    defaultDate: moment().tz('UTC'),
    icons: {
      today: 'todayText',
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right",
    },
    showTodayButton: true,
    ignoreReadonly: true,
    allowInputToggle: true,
    useCurrent: true,
  });

  // Display only date
  $(".form_date").datetimepicker({
    timeZone: 'UTC',
    format: "YYYY-MM-DD",
    defaultDate: moment().tz('UTC'),
    icons: {
      today: 'todayText',
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right",
    },
    showTodayButton: true,
    ignoreReadonly: true,
    allowInputToggle: true,
    useCurrent: true,
  });

  // Display only time
  $(".form_time").datetimepicker({
    timeZone: 'UTC',
    format: "HH:mm:ss UTC",
    defaultDate: moment().tz('UTC'),
    icons: {
      today: 'todayText',
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right",
    },
    showTodayButton: true,
    ignoreReadonly: true,
    allowInputToggle: true,
    useCurrent: true,
  });
})