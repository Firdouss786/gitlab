# Faults / Logbook

### Types of Fault
There are several ways to raise a Fault, – a traditional logbook fault, a troubleshooting request, and a verbal fault (the latter has not been implemented yet). Each of these use the Fault table for persistence but require different validations and custom logic.

These different types of faults are split into separate classes, under the `/fault` directory. You can see them in use, by example, in the FaultsController (`Fault::Logbook`) and IssuesController (`Fault::Issue`).

### State Machine
We opted for a light-weight mechanism for state management – using enums and custom validators – extracted into its own module (`app/models/fault/state_machine.rb`). Testing for this state machine is performed in `test/models/fault_test.rb`

#### States

 - Active: All fault objects have an initial state of `active`.

 - Error: This means a record was entered in error, and it should be undone / unreported. Once a record has entered into the `error` state, neither its attributes or state can be further changed.

### Validations

#### Creation (Logbook)
**Auto assigned values:**
- `user` will be defaulted to `Current.user` if user has access to `aircraft` and `activity.station`.

- `activity` will get its value from route.

- `aircraft` will be assigned `activity.aircraft`.

- `state` is using state management can only take one of these values [active, deferred, closed, deferral_closed, error].

- `impacted_seat_count` should get count of seats selected.

**User provided values:**
- `*raised_at`

- `*recorded_by` on web will be pre-filled to `Current.user`. `recorded_by` user must have access to `aircraft` and `activity.station`.

- `*logbook_reference` must be unique.

- `*discrepancy`

- `logbook_text`

- `seats_impacted` should get values from JSON.

- `*discovered`	can only be Inflight or On ground.

- `confirmed`	required only if `discovered == inflight`. Bool value.

- `cid`	required only if `discovered == inflight && confirmed == true`. Bool value.

- `action_carried`	enum - required only if `discovered == inflight && confirmed == false`.

- `inbound_deferred`	required only if `discovered == inflight`. Bool value.

- `deferral_reference`	required only if `discovered == inflight && inbound_deferred == true`.

#### Fields utilized by Fault Resolution
- `resolving_corrective_action`

#### Fields utilized by Deferral
- `defer_reason`

Besides above validations, faults/logbook model will also make sure to check for the following conditions:
- cannot add/edit fault, if originating activity for fault is in ['complete', 'error'] state.

- `aircraft` must be same as `activity.aircraft`.

- `resolving_corrective_action` must be under same fault and cannot be of type deferral.

<!-- Documentation below is not finalized yet -->

#### Fields not currently utilized in Firefly
- `approval_state` Chris added but not sure why?

- `*raised_on_flight`	required only if `discovered == inflight`. Should only list flights for aircraft_id. This was fault_flightnumber before. There is option to manually fill in this field. Currently removed.

- `technician_comment` In Servo 1, tech can add one comment to faults form. We have multiple comments solution.

- `resolved_at` seems like Servo 1 was saving the resolving_corrective_action time here.

- `defer_quantity` seems like Servo 1 was using this to save deferral part quantity.

#### Fields will be utilized by MCC
- `mel_cetegory` this was fault_deferclass before. Label was Defer Category

- `fmr`

- `pirep`

- `fault_mcccat` Found no migarion and this category is not in FIREFLY DB. Label was MCC Failure - Category. This seems Discrepancy Category.

- `fault_mccdiscrepancy` A column name with fault_mccdiscrepancy_discrepancy_id was removed via - migration. Label MCC Failure Mode. This seems Discrepancy.

- `mcc_description`	Label MCC Description.

- `controller_comment` This was mcccomment before. Label is MCC Comment.

- `mcc_status` this was fault_mccstatus before. Label is REASON.

- `mcc_priority` Removed by Chris. Label was Priority.

- `alert_raised` This was fault_mccnotification in Servo 1. Label was Recieve MCC Notification.

- `fault_customermro`	Removed by Chris. Label was Customer MRO.

- `attachment_filename`	Servo 1 has this field. Ask Chris.

- `attachment` Servo 1 has this field. Ask Chris.
