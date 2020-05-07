### To index a string (and associate with a document)
```
  Search::Index.new(klass: "User", id: 1, index_string: "chris").perform
```

### To perform a search
```
  Search.new(text: "chris").perform
  Search.new(text: "chris", klass: "User").perform # Scope down to a particular document class
```

### To flush the index
```
  rails index:flush
```

### Searchable Concern
To index a model, mixin the `Searchable` concern and define some attributes to be index on create and update

```
include Searchable

def searchable_attributes
  [name, location]
end

```

### To index a record
```
  Airline.last.index_document
```

### Updating
Currently, if you change the Model data, and re-index the record, the previous indices will be left intact, and new indices added. This is not much of a problem now, but we may fix this later by first purging the index for that record.

### Perform initial load of index data
Initially, since the Redis DB will be empty, a script has been written to index all applicable models. To perform:
`Search::IndexAll.new.perform`

### Search Results Page
For the main search results page, there needs to be a partial to support each type of search result. See `app/views/search` for examples

### Process for adding search functionality to new Model
- Include Concern and `searchable_attributes`.
- Add to `app/models/search/index_all.rb`
- Add partial to `app/views/search`
- Run `Search::IndexAll.new.perform` if you want to test it.
