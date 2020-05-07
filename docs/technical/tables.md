# Tables
To follow Thales's pre-defined Arefact designs and have better control over responsiveness, Firefly is utilizing CSS property `display: "table"` to render tables.

### Column Sorting
Sorting can be added to any column of a table.

**Steps to add sorting to columns:**
- Controller: Include `sortable` concern.
- Controller: Add `reorder(sort_pattern)` function call to your collection query. i.e. `@airports = Airport.reorder(sort_pattern)`.
- View: Add sortable function call only to column headers that need sorting. i.e. `<div class="table-head__cell"><%= sortable 'iata_code' %></div>`. If a column name is different than column header, add column header as second argument. i.e. `<%= sortable 'iata_code', 'other_name' %>`.

**Optional:** By default, all columns of controller class will be allowed to sort. However, user has the option to define specific columns before invoking collection query. i.e.

```ruby
@sortable_columns = ['name', 'country']     # set this before collection query
@airports = Airport.reorder(sort_pattern)   # collection query
```
