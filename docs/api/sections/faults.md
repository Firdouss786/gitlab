Faults
=========

Attributes:

| Column                        | Type          | Optional  | Comments  |
| :---------------------------- | :------------ | :-------  |:--------  |
| id                            | integer       | Auto      |           |
| logbook_reference*            | string        | Yes       |           |
| discovered*      	            | string        | Yes       | possible values: {'IN FLIGHT', 'ON GROUND'}  |
| technician_comment            | text          | Yes       |           |
| action_carried*               |	enum        | Yes       | required if discovered['IN FLIGHT'] & confirmed[false], possible values: { SEATRESET: "Seat reset by crew", RESET: "System reset by crew", SYSTEMOFF: "System was off, could not duplicate", CHECKSATISFACTORY: "Functional check, operational check satisfactory" }|
| logbook_text                  |	string        | Yes       |           |
| raised_on_flight*             |	string        | Yes       | required if discovered['IN FLIGHT'] |
| confirmed                     |	boolean       | Yes       | required if discovered['IN FLIGHT'] |
| inbound_deferred              |	boolean       | Yes       | required if discovered['IN FLIGHT'] |
| cid                           |	boolean       | Yes       | required if discovered['IN FLIGHT'] & confirmed[true], or discovered['ON GROUND'] |
| attachment_filename           | string        | Yes       |           |
| attachment                    |	string        | Yes       |           |
| state                         |	string        | Yes       |           |
| impacted_seat_count           |	integer       | Yes       |           |
| seats_impacted                |	text          | Yes       |           |
| raised_at                     | datetime      | Yes       |           |
| deferral_reference            | string        |	Yes       | required if inbound_deferred[true] |
| controller_comment            |	text          | Yes       |           |
| mel_cetegory                  |	string        | Yes       |           |
| alert_raised                  |	boolean       | Yes       |           |
| fmr                           |	string        | Yes       |           |
| pirep                         |	string        | Yes       |           |
| mcc_status                    |	string        | Yes       |           |
| resolved_at                   |	datetime      | Yes       |           |
| defer_quantity                |	integer       | Yes       |           |
| mcc_description               |	text          | Yes       |           |
| approval_state                |	string        | Yes       |           |
| created_at                    |	datetime	    | Auto      |           |
| updated_at                    |	datetime      |	Auto      |           |
| discrepancy_id*               |	integer       | Yes       |           |
| user_id*                      |	integer       |	No        | default: Current.user |
| recorded_by_id                | integer       | Yes       |           |
| resolving_corrective_action_id|	integer       | Yes       |           |
| aircraft_id                   |	integer       |	No        |           |
| activity_id                   |	integer       | Yes       |           |
| defer_reason_id               | integer       | Yes       |           |
| comments                      | join table    |	Yes       |           |

**(*) Asterisk values are required.**

**DATETIME Format:** Uses standardized time format - ISO8601 i.e. "2012-05-11T01:28:51Z"


Endpoints:

- [Get faults](#get-faults)
- [Get a fault](#get-a-fault)
- [Create fault](#create-fault)
- [Update fault](#update-fault)
- [Delete fault](#delete-fault)


Get faults
-------------

* `GET /airlines/:airline_id/faults.json`

###### Example JSON Response
Response: 200 OK
```json
[
    {
        "id": 349014323,
        "logbook_reference": "E123623/1",
        "discovered": "IN FLIGHT",
        "discrepancy_id": 520218854,
        "user_id": 207907133,
        "recorded_by_id": 207907133,
        "resolving_corrective_action_id": null,
        "technician_comment": "NFF ON GND TPMU OPS CHK SATIS.",
        "action_carried": "CHECKSATISFACTORY",
        "logbook_text": "3F REMOTE IS NOT WORKING. RESET ONCE",
        "raised_on_flight": "248",
        "confirmed": false,
        "inbound_deferred": false,
        "cid": false,
        "attachment_filename": null,
        "attachment": null,
        "state": "active",
        "impacted_seat_count": 1,
        "seats_impacted": "3F",
        "raised_at": "2019-01-29T21:15:00.000Z",
        "deferral_reference": null,
        "controller_comment": null,
        "aircraft_id": 708627287,
        "activity_id": 980190962,
        "mel_cetegory": null,
        "alert_raised": false,
        "fmr": null,
        "pirep": null,
        "mcc_status": null,
        "resolved_at": null,
        "defer_quantity": 0,
        "mcc_description": null,
        "defer_reason_id": null,
        "approval_state": null,
        "requires_approval": null,
        "created_at": "2019-01-30T00:00:00.000Z",
        "updated_at": "2019-01-29T15:51:00.000Z",
        "comments": [
            {
                "id": 616999509,
                "user_id": 207907133,
                "description": "This comment is from Chris Swann.",
                "commentable_type": "Fault",
                "commentable_id": 349014323,
                "created_at": "2019-05-03T14:37:26.000Z",
                "updated_at": "2019-05-03T14:37:26.000Z"
            },
            {
                "id": 674736318,
                "user_id": 757830418,
                "description": "Maaz Siddiqui made this comment.",
                "commentable_type": "Fault",
                "commentable_id": 349014323,
                "created_at": "2019-05-03T14:37:26.000Z",
                "updated_at": "2019-05-03T14:37:26.000Z"
            },
            {
                "id": 686401682,
                "user_id": 207907133,
                "description": "Another comment by Chris Swann.",
                "commentable_type": "Fault",
                "commentable_id": 349014323,
                "created_at": "2019-05-03T14:37:26.000Z",
                "updated_at": "2019-05-03T14:37:26.000Z"
            }
        ],
        "url": "http://localhost:3000/faults/349014323.json"
    },
    {
        "id": 379593659,
        "logbook_reference": null,
        "discovered": null,
        "discrepancy_id": null,
        "user_id": 207907133,
        "recorded_by_id": null,
        "resolving_corrective_action_id": null,
        "technician_comment": null,
        "action_carried": null,
        "logbook_text": null,
        "raised_on_flight": null,
        "confirmed": false,
        "inbound_deferred": false,
        "cid": false,
        "attachment_filename": null,
        "attachment": null,
        "state": "active",
        "impacted_seat_count": null,
        "seats_impacted": "22G",
        "raised_at": null,
        "deferral_reference": null,
        "controller_comment": null,
        "aircraft_id": 708627287,
        "activity_id": null,
        "mel_cetegory": null,
        "alert_raised": false,
        "fmr": null,
        "pirep": null,
        "mcc_status": null,
        "resolved_at": null,
        "defer_quantity": null,
        "mcc_description": "HANDSET HAS ERROR",
        "defer_reason_id": null,
        "approval_state": "approved",
        "requires_approval": null,
        "created_at": "2019-05-03T14:37:26.000Z",
        "updated_at": "2019-05-03T14:37:26.000Z",
        "comments": [],
        "url": "http://localhost:3000/faults/379593659.json"
    }
]
```


Get a fault
-------------

* `GET /faults/:fault_id.json`

###### Example JSON Response
Response: 200 OK
```json
{
    "id": 349014323,
    "logbook_reference": "E123623/1",
    "discovered": "IN FLIGHT",
    "discrepancy_id": 520218854,
    "user_id": 207907133,
    "recorded_by_id": 207907133,
    "resolving_corrective_action_id": null,
    "technician_comment": "NFF ON GND TPMU OPS CHK SATIS.",
    "action_carried": "CHECKSATISFACTORY",
    "logbook_text": "3F REMOTE IS NOT WORKING. RESET ONCE",
    "raised_on_flight": "248",
    "confirmed": false,
    "inbound_deferred": false,
    "cid": false,
    "attachment_filename": null,
    "attachment": null,
    "state": "active",
    "impacted_seat_count": 1,
    "seats_impacted": "3F",
    "raised_at": "2019-01-29T21:15:00.000Z",
    "deferral_reference": null,
    "controller_comment": null,
    "aircraft_id": 708627287,
    "activity_id": 980190962,
    "mel_cetegory": null,
    "alert_raised": false,
    "fmr": null,
    "pirep": null,
    "mcc_status": null,
    "resolved_at": null,
    "defer_quantity": 0,
    "mcc_description": null,
    "defer_reason_id": null,
    "approval_state": null,
    "requires_approval": null,
    "created_at": "2019-01-30T00:00:00.000Z",
    "updated_at": "2019-01-29T15:51:00.000Z",
    "comments": [
        {
            "id": 616999509,
            "user_id": 207907133,
            "description": "This comment is from Chris Swann.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-03T14:37:26.000Z",
            "updated_at": "2019-05-03T14:37:26.000Z"
        },
        {
            "id": 674736318,
            "user_id": 757830418,
            "description": "Maaz Siddiqui made this comment.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-03T14:37:26.000Z",
            "updated_at": "2019-05-03T14:37:26.000Z"
        },
        {
            "id": 686401682,
            "user_id": 207907133,
            "description": "Another comment by Chris Swann.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-03T14:37:26.000Z",
            "updated_at": "2019-05-03T14:37:26.000Z"
        }
    ],
    "url": "http://localhost:3000/faults/349014323.json"
}
```


Create fault
-------------

* `POST /airlines/:airline_id/faults.json`

###### Example JSON Body
Content-Type: application/json
```json
{
    "fault": {
        "logbook_reference": "E123623/1",
        "discovered": "ON GROUND",
        "discrepancy_id": 520218854,
        "recorded_by_id": 207907133,
        "logbook_text": "Fault created via API",
        "aircraft_id": 708627287
    }
}
```
Comment(s) cannot be defined at the time of fault creation. To create a comment, refer to [Comments API](./sections/comments.md) section.


###### Example JSON Response
Response: 201 CREATED
```json
{
    "id": 807209348,
    "logbook_reference": "E123623/1",
    "discovered": "IN FLIGHT",
    "discrepancy_id": 520218854,
    "user_id": 207907133,
    "recorded_by_id": 207907133,
    "resolving_corrective_action_id": null,
    "technician_comment": null,
    "action_carried": null,
    "logbook_text": "Fault created via API",
    "raised_on_flight": null,
    "confirmed": false,
    "inbound_deferred": false,
    "cid": false,
    "attachment_filename": null,
    "attachment": null,
    "state": "active",
    "impacted_seat_count": null,
    "seats_impacted": null,
    "raised_at": null,
    "deferral_reference": null,
    "controller_comment": null,
    "aircraft_id": 708627287,
    "activity_id": null,
    "mel_cetegory": null,
    "alert_raised": false,
    "fmr": null,
    "pirep": null,
    "mcc_status": null,
    "resolved_at": null,
    "defer_quantity": null,
    "mcc_description": null,
    "defer_reason_id": null,
    "approval_state": null,
    "requires_approval": null,
    "created_at": "2019-05-03T16:04:11.000Z",
    "updated_at": "2019-05-03T16:04:11.000Z",
    "comments": [],
    "url": "http://localhost:3000/faults/807209348.json"
}
```


Update fault
-------------

* `PATCH /faults/:fault_id.json`

###### Example JSON Body
Content-Type: application/json
```json
{
    "fault": {
        "logbook_reference": "E123623/555",
        "logbook_text": "UPDATED FROM API"
    }
}
```
Comment(s) cannot be updated at the time of fault update. To update a comment, refer to [Comments API](./sections/comments.md) section.

###### Example JSON Response
Response: 200 OK
```json
{
    "id": 807209348,
    "logbook_reference": "E123623/555",
    "discovered": "IN FLIGHT",
    "discrepancy_id": 520218854,
    "user_id": 207907133,
    "recorded_by_id": 207907133,
    "resolving_corrective_action_id": null,
    "technician_comment": null,
    "action_carried": null,
    "logbook_text": "UPDATED FROM API",
    "raised_on_flight": null,
    "confirmed": false,
    "inbound_deferred": false,
    "cid": false,
    "attachment_filename": null,
    "attachment": null,
    "state": "active",
    "impacted_seat_count": null,
    "seats_impacted": null,
    "raised_at": null,
    "deferral_reference": null,
    "controller_comment": null,
    "aircraft_id": 708627287,
    "activity_id": null,
    "mel_cetegory": null,
    "alert_raised": false,
    "fmr": null,
    "pirep": null,
    "mcc_status": null,
    "resolved_at": null,
    "defer_quantity": null,
    "mcc_description": null,
    "defer_reason_id": null,
    "approval_state": null,
    "requires_approval": null,
    "created_at": "2019-05-03T16:04:11.000Z",
    "updated_at": "2019-05-03T16:06:08.000Z",
    "comments": [],
    "url": "http://localhost:3000/faults/807209348.json"
}
```


Delete fault
-------------

* `DELETE /faults/:fault_id.json`

###### Example JSON Response
Response: 204 No Content
