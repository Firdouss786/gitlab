Airlines
=========

Endpoints:

- [Get Airlines](#get-airlines)
- [Get An Airline](#get-an-airline)


# Get airlines
-------------

* `GET /airlines.json`

###### Example JSON Response
```json
[
  {
    "id": 110458917,
    "iata_code": "BA",
    "icao_code": "BAW",
    "name": "British Airways",
    "alias": null,
    "callsign": "SPEEDBIRD",
    "country": "United Kingdom",
    "customer": true,
    "description": null,
    "created_at": "2019-02-25T21:23:17.000Z",
    "updated_at": "2019-02-25T21:23:17.000Z",
    "url": "https://firefly.staging.topcareife.com/airlines/110458917.json"
  },
  {
    "id": 228924277,
    "iata_code": "JB",
    "icao_code": "JBU",
    "name": "Jet Blue",
    "alias": null,
    "callsign": "Jet Blue",
    "country": "United States",
    "customer": true,
    "description": null,
    "created_at": "2019-02-25T21:23:17.000Z",
    "updated_at": "2019-02-25T21:23:17.000Z",
    "url": "https://firefly.staging.topcareife.com/airlines/228924277.json"
  }
]
```


# Get an airline
-------------

* `GET /airlines/:id.json`

###### Example JSON Response
```json
{
  "id": 110458917,
  "iata_code": "BA",
  "icao_code": "BAW",
  "name": "British Airways",
  "alias": null,
  "callsign": "SPEEDBIRD",
  "country": "United Kingdom",
  "customer": true,
  "description": null,
  "created_at": "2019-02-25T21:23:17.000Z",
  "updated_at": "2019-02-25T21:23:17.000Z",
  "url": "https://firefly.staging.topcareife.com/airlines/110458917.json"
}
```
