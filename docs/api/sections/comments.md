Comments
=========
Comments model utilizes polymorphic association and this document will reference any parent class of comments as :commentable.

Attributes:

| Column                        | MYSQL Type    | Optional  |
| :---------------------------- | :------------ | :-------  |
| id                            | integer       | Auto      |
| user_id                       | integer       | Auto      |
| description      	            | text          | No        |
| created_at                    |	datetime	    | Auto      |
| updated_at                    |	datetime      |	Auto      |

**DATETIME Format:** Uses standardized time format - ISO8601 i.e. "2012-05-11T01:28:51Z"


Endpoints:

- [Create comment](#create-comment)
- [Update comment](#update-comment)
- [Delete comment](#delete-comment)


Create comment
-------------

* `POST /:commentable/:commentable_id/comments.json`

###### Example JSON Body
Content-Type: application/json
```json
{
    "comment": {
        "description": "Maaz created this comment from API."
    }
}
```

###### Example JSON Response
Response: 201 CREATED
```json
{
    "id": 349014323,
    "logbook_reference": "E123623/1",
    "discovered": "IN FLIGHT",
    "discrepancy_id": 520218854,
    "user_id": 207907133,
    "raised_by_id": 207907133,
    "corrective_action_id": null,
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
    "latest_corrective_action_id": null,
    "defer_reason_id": null,
    "created_at": "2019-01-30T00:00:00.000Z",
    "updated_at": "2019-01-29T15:51:00.000Z",
    "approval_state": null,
    "requires_approval": null,
    "comments": [
        {
            "id": 616999509,
            "user_id": 207907133,
            "description": "This comment is from Chris Swann.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-01T18:31:46.000Z",
            "updated_at": "2019-05-01T18:31:46.000Z"
        },
        {
            "id": 674736318,
            "user_id": 757830418,
            "description": "Maaz Siddiqui made this comment.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-01T18:31:46.000Z",
            "updated_at": "2019-05-01T18:31:46.000Z"
        },
        {
            "id": 686401682,
            "user_id": 207907133,
            "description": "Another comment by Chris Swann.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-01T18:31:46.000Z",
            "updated_at": "2019-05-01T18:31:46.000Z"
        },
        {
            "id": 686401722,
            "user_id": 207907133,
            "description": "Maaz created this comment from API.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-03T01:03:12.000Z",
            "updated_at": "2019-05-03T01:03:12.000Z"
        }
    ]
}
```


Update comment
-------------

* `PATCH /comments/:comment_id.json`

###### Example JSON Body
Content-Type: application/json
```json
{
    "comment": {
        "description": "Comment updated from API."
    }
}
```

###### Example JSON Response
Response: 200 OK
```json
{
    "id": 349014323,
    "logbook_reference": "E123623/1",
    "discovered": "IN FLIGHT",
    "discrepancy_id": 520218854,
    "user_id": 207907133,
    "raised_by_id": 207907133,
    "corrective_action_id": null,
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
    "latest_corrective_action_id": null,
    "defer_reason_id": null,
    "created_at": "2019-01-30T00:00:00.000Z",
    "updated_at": "2019-01-29T15:51:00.000Z",
    "approval_state": null,
    "requires_approval": null,
    "comments": [
        {
            "id": 616999509,
            "user_id": 207907133,
            "description": "This comment is from Chris Swann.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-01T18:31:46.000Z",
            "updated_at": "2019-05-01T18:31:46.000Z"
        },
        {
            "id": 674736318,
            "user_id": 757830418,
            "description": "Maaz Siddiqui made this comment.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-01T18:31:46.000Z",
            "updated_at": "2019-05-01T18:31:46.000Z"
        },
        {
            "id": 686401682,
            "user_id": 207907133,
            "description": "Another comment by Chris Swann.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-01T18:31:46.000Z",
            "updated_at": "2019-05-01T18:31:46.000Z"
        },
        {
            "id": 686401722,
            "user_id": 207907133,
            "description": "Comment updated from API.",
            "commentable_type": "Fault",
            "commentable_id": 349014323,
            "created_at": "2019-05-03T01:03:12.000Z",
            "updated_at": "2019-05-03T01:19:27.000Z"
        }
    ]
}
```


Delete comment
-------------

* `DELETE /comments/:comment_id.json`

###### Example JSON Response
Response: 204 No Content
