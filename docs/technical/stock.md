# Stock

## Station Stock Pages
Routes: `rails routes | grep stock_locations`

A `StockLocation` holds many `StockItem`'s. Stock items can be in one of the following states, and generally 'flow' in this order:

`inspecting, serviceable, installed, removed, unserviceable, transiting, quarantined, scrapped`

The `StockLocations::StatesController` displays lists of StockItems based on the state they are in. The route for this looks like:

`/stations/123/stock_locations/456/states/serviceable`

The `StockLocations::StatesController` then renders the appropriate view from `app/views/stock_locations/states/`

## Transitioning States
A stock item moves from state to state by initiating a `Transfer`. The `TransfersController` handles this, responding to a form from the view (see `app/views/stock_locations/states/inspecting/_stock_item.html.erb` for example)

A callback on the Transfer triggers the state change of the Stock Item (`stock_item.transition_to_state :serviceable`)

## Stock Item State Machine
Each stock item persists its state to the database. Each state is represented by a class (`/models/stock_item/*_state.rb`). These classes are where the valid destination states, and model validations should go.

## State Transfers
- From `quarantined` state can be transfer to `inspecting` or `unserviceable` states.
- From `unserviceable` state can be transfer to `transiting` or `scrapped` states.
- From `inspecting` state can be transfer to `serviceable` or `unserviceable` or `quarantined` states.
- From `serviceable` state can be transfer to `inspecting` or `unserviceable` or `quarantined` states or `installed` states.
- From `installed` state can be transfer to `removed` state only none other states.
- From `removed` state can be transfer to `inspecting` or `unserviceable` states.