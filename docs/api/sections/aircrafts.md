Aircrafts
=========
Aircrafts belong to an fleet, so you must know the ID of the fleet first.

Endpoints:

- [Get Aircrafts](#get-aircrafts)
- [Get An Aircraft](#get-an-aircraft)

Get Aircrafts
-------------

* `GET /fleets/:id/aircrafts`

###### Example JSON Response
```json
[
   {
      "id":70429306,
      "tail":"G-STBC",
      "msn":"N89881",
      "fin":"G-STBA",
      "registration":"G-STBC",
      "eis":"2017-09-25T23:52:43.000Z",
      "tot":"2017-09-25T23:52:43.000Z",
      "description":"BAW Aircraft G-STBC",
      "locked":false,
      "active":true,
      "created_at":"2019-02-22T00:04:18.000Z",
      "updated_at":"2019-02-22T00:04:18.000Z",
      "url":"http://localhost:3000/aircrafts/70429306.json"
   },
   {
      "id":142137287,
      "tail":"N70020",
      "msn":"N70020",
      "fin":"N70020",
      "registration":"N70020",
      "eis":"2017-09-25T23:52:43.000Z",
      "tot":"2017-09-25T23:52:43.000Z",
      "description":"N70020",
      "locked":false,
      "active":true,
      "created_at":"2019-02-22T00:04:18.000Z",
      "updated_at":"2019-02-22T00:04:18.000Z",
      "url":"http://localhost:3000/aircrafts/142137287.json"
   },
   {
      "id":441860061,
      "tail":"G-STBD",
      "msn":"N89881",
      "fin":"G-STBA",
      "registration":"G-STBD",
      "eis":"2017-09-25T23:52:43.000Z",
      "tot":"2017-09-25T23:52:43.000Z",
      "description":"BAW Aircraft G-STBD",
      "locked":false,
      "active":true,
      "created_at":"2019-02-22T00:04:18.000Z",
      "updated_at":"2019-02-22T00:04:18.000Z",
      "url":"http://localhost:3000/aircrafts/441860061.json"
   },
   {
      "id":708627287,
      "tail":"G-STBA",
      "msn":"N89881",
      "fin":"G-STBA",
      "registration":"G-STBA",
      "eis":"2017-09-25T23:52:43.000Z",
      "tot":"2017-09-25T23:52:43.000Z",
      "description":"BAW Aircraft G-STBA",
      "locked":false,
      "active":true,
      "created_at":"2019-02-22T00:04:18.000Z",
      "updated_at":"2019-02-22T00:04:18.000Z",
      "url":"http://localhost:3000/aircrafts/708627287.json"
   },
   {
      "id":859151087,
      "tail":"G-STBB",
      "msn":"N89881",
      "fin":"G-STBA",
      "registration":"G-STBB",
      "eis":"2017-09-25T23:52:43.000Z",
      "tot":"2017-09-25T23:52:43.000Z",
      "description":"BAW Aircraft G-STBB",
      "locked":false,
      "active":true,
      "created_at":"2019-02-22T00:04:18.000Z",
      "updated_at":"2019-02-22T00:04:18.000Z",
      "url":"http://localhost:3000/aircrafts/859151087.json"
   }
]
```

Get Aircraft Configs
-------------

* `GET /aircrafts/:id.json`

###### Example JSON Response
```json
{
   "id":70429306,
   "tail":"G-STBC",
   "msn":"N89881",
   "fin":"G-STBA",
   "registration":"G-STBC",
   "eis":"2017-09-25T23:52:43.000Z",
   "tot":"2017-09-25T23:52:43.000Z",
   "description":"BAW Aircraft G-STBC",
   "locked":false,
   "active":true,
   "created_at":"2019-02-22T00:04:18.000Z",
   "updated_at":"2019-02-22T00:04:18.000Z",
   "url":"http://localhost:3000/aircrafts/70429306.json"
}
```
