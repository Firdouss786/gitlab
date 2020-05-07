# Corrective Action

### Validations

#### Creation
**Auto assigned values:**
- `*user` will be set to `Current.user` if the logged in user has access to aircraft and `self.activity.station`.

- `*activity` will get its value from route. This might be different from `fault.activity`.

- `*fault` will get its value from params.

- `*replacement` only if `maintenance_action` is `Replaced Consumable` or `Replaced LRU`.

**User provided values:**
- `*job_started_at` on web will be auto-filled to `Time.now`. Must be >= `fault.boarded_at`.

- `*performed_by` on web auto-filled to `Current.user`. Must have access to aircraft and `self.activity.station`.

- `*maintenance_action` must be from `MaintenanceAction` table.

- `*logbook_reference` on web will be auto-filled to `fault.logbook_reference`.

- `*logbook_text`

- `*document_reference`

Besides above validations, corrective action model will also make sure to check for the following conditions:
- cannot add/edit corrective action if activity is in complete or error state.

- cannot add corrective action if fault is in closed or deferral_closed state.

- cannot add corrective action if fault is already deferred.

- aircraft for activity and fault must be same.

- cannot destroy corrective action if originating activity is in complete or error state.

- destroying ca should revert fault state to active if it was in closed state and resolving_corrective_action was same as the deleted one.

- destroying ca should revert fault state to deferred if it was in deferred_closed state and resolving_corrective_action was same as the deleted one.

#### Fields no longer used in Firefly
- `batch_number` not using in Firefly but still present. Moved to Replacement.

- `batch_quantity` not using in Firefly but still present. Moved to Replacement.

- `removal_reason` not using in Firefly but still present. Moved to Replacement.

# Deferrals

Servo "Defer" form uses CorrectiveAction table in backend to store data. Only form labels are changed when form is rendered. Deferral document is same here and under deferrals.

**CorrectiveAction model mapping to Defer form:**
- `*job_started_at` -> Date.

- `*performed_by` -> Deferred by.

- `*defer_class` -> Defer Category. Can accept values from A to D.

- `*opdef` -> Operational Deficiency. Boolean value.

- `*document_reference` -> Deferral Reference.

- `*defer_reason` -> Defer Reason.

- `*product` -> PN Needed. Only required if 'no part' is selected in `defer_reason`.

- `*logbook_text` -> Action Description.

** refers to required field.*
