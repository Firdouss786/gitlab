# Modal UI Component
We are using a custom modal component. Here is how it works:

### To implement a modal:
```
<div class="your-class" data-action="click->modal#expand">

  <p>Some Content</p>

  <div class="modal hidden" data-target="modal.content">
    <p>This will appear in the modal</p>
  </div>

</div>
```

As you can see, clicking on the outer div will cause the modal controller to search for a nested `data-target` of `modal.content` and expand it. Clicking anywhere outside of the modal will hide it. It does this by calling `hide` method.

#### Hiding modal by triggering an event:
Besides clicking outside of modal and closing it, modal can also be configured to hide by triggering an event from inside.

**Setup target(s) to close modal:**
1. Add `hide` method call to target event. i.e. `data-action="click->modal#hide"`
2. Add `skip_expand` class to target and all of its visible child elements.

#### The modal backdrop
The backdrop for the modal is located in `app/views/layouts/application.html.erb`. All modals use this backdrop.

```
<span class="modal-backdrop hidden" data-target="modal.backdrop" data-action="click->modal#hideBackdrop"></span>
```

The behavior is attached via the data attributes, and so you can feel free to change the classes if you wish to restyle it. The modal controller will add and remove the `expanded` class.
