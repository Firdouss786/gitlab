# Sign-off

Sign-off uses `Activity` database table in backend. However, we do a model file for Sign-off to perform validations. Controller and views are separate from `activity`. If successful, sign-off will only update activity's `state`, `boarded_at`, `unboarded_at`, `closed_by` and `closed_at` columns.

### Validations

#### Creation
**Auto assigned values:**
- `closed_by` will be set to `Current.user` if logged-in user has access to aircraft and `activity.station`.
- `closed_at` will be set to `Time.now` if all validations passes.
- `state`	will be set to `complete` if all validations passes.

**User provided values:**
- `*boarded_at`
- `*unboarded_at` must be after boarded_at.

Following conditions will also be checked:
- cannot sign-off if activity is already in complete or error state.
- all open_deferrals must be re-deferred or resolved (deferred_closed).
- all logbook faults must be closed or deferred.
