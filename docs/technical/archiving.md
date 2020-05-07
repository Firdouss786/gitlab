# Overview
For an object to be archived, its class must mix in the Archivable concern. It must also have an archival_id column to store the id for the archival.

Once the concern is mixed in, the following methods become available to the class and its instances:

## Class Methods
 - archived
 - published
 - is_archivable?

## Instance methods
 - archived?
 - published?
 - archive_by(user)
 - archived_at
 - archived_by
 - restore

## Usage
```
task_template = TaskTemplate.new
user = User.find_by(email: 'chris.swann@thalesinflight.com')
task_template.archive_by(user)
task_template.archived? #=> true
task_template.restore
```

## Adding archival column
`add_reference :task_templates, :archival, index: true`
