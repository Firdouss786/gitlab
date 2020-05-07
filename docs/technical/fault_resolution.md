# Fault Resolution

Fault Resolution uses Fault database table in backend. Controller and views are separate. If successful, fault resolution will only update faults's `state` and `resolving_corrective_action` columns.

Following conditions will be checked via fault's model:
- cannot update fault if current activity is in complete or error state.
- resolving corrective action must be under same fault and cannot be of type deferral.
- fault attributes are reverted if state changed to active/deferred from closed/deferral_closed.

#### Fault state will be updated as follows:

| Current Fault State           | Resolved Selected | Fault's New State |
| :---------------------------- | :---------------- | :---------------- |
| active                        | Yes               | closed            |
| active                        | No                | *no_change*       |
| closed                        | Yes               | *no_change*       |
| closed                        | No                | activities        |
| deferred      	              | Yes               | deferral_closed   |
| deferred      	              | No                | *no_change*       |
| deferred_closed               |	Yes     	        | *no_change*       |
| deferred_closed               |	No       	        | deferred          |
