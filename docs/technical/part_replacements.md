# Part Replacements
A `Replacement` represents 2 `StockItem`s – one being installed to the aircraft, and one being removed. There are two types of `Replacement`s – consumable, and rotable. In the case of a consumable, currently there is no need for a removal part, as we regard the action as simply 'consuming from a batch'.

The `Replacement` model contains the validations and callbacks for post-install actions, so this is a good place to start to understand the code.

### Events
`StockItem`s are serialized parts, and hold the current state (location of the part, status of the part etc). `Event`s are hold the change history of a `StockItem` – where it has been, when it was shipped, adjustments to quantity etc.

An `Event` is actually polymorphic – its `eventable` can either be an `Adjustment` or a `Transfer`.

### Adjustments
An `Adjustment` only applies to consumable parts, and represents the additions or subtractions to the quantity of a `StockItem`. These can be rolled back, for example when a mistake is made. `Adjustment`s are also polymorphic, with its `adjustable` being a `Replacement`. In the future we will have other models which can be adjusted (think stock takes / audits, manufacturing etc).

### Transfer
A `Transfer` is a legacy concept from Servo 1.x – it captures movements of the `StockItem`.
