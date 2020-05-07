# Deferral

### Validations

#### Creation
**Auto assigned values:**
- `*user` will be set to `Current.user` if the logged in user has access to aircraft and `self.activity.station`.
- `*activity` will get its value from route. This might be different from fault.activity.
- `*fault` will get its value from params.
- `*maintenance_action` will be set as defer.

**User provided values:**
- `*job_started_at` on web will be auto-filled to `Time.now`. Must be >= `activity.boarded_at`.
- `*performed_by` on web auto-filled to `Current.user`. Must have access to aircraft and `self.activity.station`.
- `*opdef` can only be true or false.
- `*document_reference`
- `*defer_reason` must be one from `DeferReason` model.
- `*product` must be a product from `self.activity.aircraft.bill_of_materials` if `defer_reason` is selected as `no_parts`.
- `*logbook_text`

Besides above validations, corrective action/deferral model will also make sure to check for the following conditions:
- aircraft for activity and fault must be same.
- cannot add another deferral if fault is already deferred.
- cannot edit deferral if originating activity is in complete or error state.
- cannot destroy deferral if originating activity is in complete or error state.
- cannot defer if fault is in closed or deferral_closed state.
- destroying deferral will revert fault attributes.

### Deferral Mapping to Corrective Action Model

Servo "Defer" form uses CorrectiveAction table in backend to store data. Only form labels are changed when form is rendered. We have followed the same architecture in FireFly.

- `*job_started_at` -> Date.
- `*performed_by` -> Deferred by.
- `*defer_class` -> Defer Category. Can accept values from A to D. Currently missing from FireFly.
- `*opdef` -> Operational Deficiency. Boolean value.
- `*document_reference` -> Deferral Reference.
- `*defer_reason` -> Defer Reason.
- `*product` -> PN Needed. Only required if 'no part' is selected in `defer_reason`.
- `*logbook_text` -> Action Description.

** refers to required field.*
