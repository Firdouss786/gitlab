# Redis Logger

There are some events we may want to persist in Redis rathern than just in the syslog, so that they are easier to surface in the UI.

## Logging an event
```
RedisLogger.new({klass: "User", document_id: 1, message: "user authenticated.", details: user.as_json}).save
```


## Query events
```
RedisLogger::Query.new(klass: "User", document_id: 1).perform
```
