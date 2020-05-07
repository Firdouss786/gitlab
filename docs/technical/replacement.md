# Replacement

### Validations

#### Creation
**Auto assigned values:**
- `*category` will be set to 'rotable' or 'consumable' based on `installed_product` category.

**User provided values:**

IF 'Replaced Consumable' is selected in `maintenance_action`:
- `*installed_product` must be within aircraft Bill of Materials (BOM).
- `*installed_stock_item` must be within `installed_product` and also aircraft BOM.
- `*install_quantity`	must be within available quantity at `activity.station`.

IF 'Replaced LRU' is selected in `maintenance_action`:
- `*on_wing_position`
- `*removed_product` must be under aircraft BOM.
- `*removed_stock_item` must have 'installed' state under the same aircraft and must be under `removed_product`.
- `removed_model_numbers` can be multiple unique values between 1 and 16. *i.e. "1, 2, 3" or "[1, 2, 3]"*.
- `removed_revision` can be any alphabet from A to Z.
- `*installed_product` must be within aircraft Bill of Materials (BOM).
- `*installed_stock_item` must be within `installed_product` and also aircraft BOM.
- `*removal_reason` can only be one of the reason of `removed_product`.

** refers to required field.*

### AJAX Mechanism
Most of `replacement` model fields rely on AJAX functionality to pull in data progressively based on previous selections. Because replacement does not have a controller file, all AJAX actions are defined under `app/controllers/corrective_actions_controller.rb`.

**There are two types of fields:**
**Dropdown:** loads a partial of `options_for_select` with requested data and returns.
**Data Field:** loads required value and return as JSON.

**JavaScript:**
`app/javascript/packs/controllers/corrective-action_controller.js`

JavaScript requests and receives the data from server via fetch. It also does the manipulation of fields based on selected options.

**Field visibility conditions:**
IF 'Replaced Consumable' is selected in `maintenance_action`:

`installed_product` value is selected &rarr; `installed_stock_item` value is selected &rarr; `install_quantity`.

IF 'Replaced LRU' is selected in `maintenance_action`:

`on_wing_position`
`removal_reason`
`removed_model_numbers`
`removed_revision`
`removed_stock_item`
`removed_product` value is selected &rarr;
`installed_product`
`installed_stock_item`
*Two extra fields also gets visible named 'MOD on' and 'REV on' but they don't correspond to any table in replacement.*
