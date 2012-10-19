DirtyForm
=========

Good UX design dictates that a ```Save``` button is disabled until something changes or the data within a form is not valid. This little class makes it easy to implement.

Define a container to watch for changes in. If any form element (select, input, textarea, etc.) values within the container are modified from their original state, a ```dirty``` function is called. If all of the elements return to their original state, then the ```clean``` function is called.

There is also a ```both``` function which will be called in either case and it is possible to check if things are dirty or not with ```dirtyForm.isDirty```.

``` coffeescript

DirtyForm = require('app/DirtyForm')

df = new DirtyForm
    form: $('formdiv')
    both: (event, data) ->
        validate(event, data)

validate = (event, data) ->
    if df.isDirty && formData.name && formData.age > 10
        enableButton(saveButton)
    else
        disableButton(saveButton)
```

The DirtyForm class is wrapped in [```simplified CommonJS wrapping```](http://requirejs.org/docs/whyamd.html#sugar) because that is what I use for my site.

DirtyForm depends on a recent version of jquery.

DirtyForm was heavily influenced by the [acvwilson dirty_form](https://github.com/acvwilson/dirty_form) project.