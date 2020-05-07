## Internationalization

By default Servo is in English. However we are using the in-build Rails internationalization feature to achieve consistent wording of titles and labels across the application.

ie. Instead of putting `<label>Ground Time</label>`, you would write `<label><% t :ground_time %></label>`, then declare the value of `:ground_time` in `config/locales/en.yml`.
