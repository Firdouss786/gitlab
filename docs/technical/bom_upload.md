# Bill of Materials (BOM)
BOM is a list of all products that can be installed in an aircraft. Firefly has the option to upload this pre-defined list (BOM) to aircraft configurations.

### File Format
BOM list must be a MS Excel file and specifically in `.xlsx` format (not even .xls or .csv).

### Required Columns
BOM list will not upload if any of the following column headers are missing:

**Product Category**\
`Product Family`, `Product Family Type (ROTABLE, CONSUMABLE)`, `Product Family description`

**Product**\
`Product Part Number`, `Product Name`, `Product Price`, `Product Shelf Life`, `Product Description`

**Product Allotment**\
`Quantity`

### Validations

**Product Category**
- `Product Family` - must be a unique value in `ProductCategory` table. New `ProductCategory` will only be generated if this value is not found. If value is found then other Product Category fields will be ignored.
- `Product Family Type (ROTABLE, CONSUMABLE)` - string and must be ROTABLE or CONSUMABLE. If something else is found then CONSUMABLE will be used instead.

**Product**
- `Product Part Number` - must be unique value in `Product` table. New `Product` will only be generated if this value is not found. If value is found then other Product fields will be ignored.
- `Product Price` - will be converted to number.
- `Product Shelf Life` - will be converted to number.

**Product Allotment**
- `Quantity` - if found, will be converted to number otherwise zero will be used.
