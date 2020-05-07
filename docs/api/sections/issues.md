Issues
=========
Issues are also known as troubleshooting requests (TSR's).

Endpoints:

- [Get issues](#get-issues)

Get issues
-------------

* `GET /airlines/7/issues.json` will return a list of active issues for the airline with an ID of `7`.

###### Example JSON Response
```json
[
  {
    "id": 7,
    "iata_code": "AA",
    "icao_code": "AAL",
    "name": "American Airlines",
    "alias": "true",
    "callsign": "AMERICAN",
    "country": "United States",
    "customer": true,
    "description": null,
    "created_at": "2018-08-21T00:00:00.000Z",
    "updated_at": "2018-08-23T00:16:43.000Z",
    "url": "https://firefly.staging.topcareife.com/airlines/7.json"
  }
]
```

###### Copy as cURL

``` shell
curl -s -H "Authorization: Bearer $ACCESS_TOKEN" https://firefly.staging.topcareife.com/airlines/7/issues.json
```
