# Jump Menu
The jump menu looks like a breadcrumb, but acts differently. There are two variants, one for Airlines, and one for Stations.

## Behavior
When the user clicks on the root crumb of the Station Jump Menu, which would be the station name, a list of other stations unfurl beneath the breadcrumb. The user can then click one of those list items to switch to that station.

Where the behavior differs from a standard breadcrumb, is that the current location will be maintained even when the station is changed. For example, if I am on `/stations/lhr/users` and switch to `lax`, i'll be on `/stations/lax/users`. If I'm on `/stations/lhr/workload` and switch to `lax`, i'll be on `/stations/lax/workload`.

This makes it easy to quickly switch stations and compare data, such as the workload for station X, or the deferrals for station y.

## Tests
Tests for this feature are in `test/integration/jump_menu_test.rb`

## Implementation
The breadcrumb contains the jump menu as a partial (`app/views/shared/_station_jump_menu.html.erb`)
```
<%= breadcrumb do %>
  <%= breadcrumb_jump @station.name, stations_path %>
  <%= breadcrumb_active_item "Workload" %>

  <%= render 'shared/station_jump_menu' %>
<% end %>
```

This partial uses a helper method (`app/helpers/jump_links_helper.rb`) to build the special jump links.

The helper figures out which page your are on, so you simply pass it the station you wish to switch to and it will figure out the appropriate URL
```
<%= jump_to_station station.name, station %>
# => /stations/331801366/users
```
