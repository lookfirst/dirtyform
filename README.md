DirtyForm
=========

Good UX design dictates that a ```Save``` button is disabled until something changes or the data within a form is not valid. This little class makes it easy to implement.

Define a container to watch for changes in. If any form element (select, input, textarea, etc.) values within the container are modified from their original state, a ```dirty``` function is called. If all of the elements return to their original state, then the ```clean``` function is called.

There is also a ```both``` function which will be called in either case and it is possible to check if things are dirty or not with ```dirtyForm.isDirty```.

This is a rather contrived example, but hopefully gets the point across...

``` html

<div id="formdiv">
    <input type="text" name="name" id="name" />
    <input type="text" name="age" id="age" />
    <input type="submit" id="saveButton" />
</div>
```

``` coffeescript

DirtyForm = require('app/DirtyForm')

saveButton = $('#saveButton')

enableButton = (obj) ->
    if obj
        obj.removeClass('disabled')
        obj.removeAttr('disabled')
        return obj

disableButton = (obj) ->
    if obj
        obj.addClass('disabled')
        obj.attr('disabled', 'disabled')
        return obj

validate = (event, data) ->
    if df.isDirty && $('#name').val() && $('#age').val() > 10
        enableButton(saveButton)
    else
        disableButton(saveButton)

df = new DirtyForm
    form: $('formdiv')
    both: (event, data) ->
        validate(event, data)
```

The DirtyForm class is wrapped in [```simplified CommonJS wrapping```](http://requirejs.org/docs/whyamd.html#sugar) because that is what I use for my site.

DirtyForm depends on a recent version of jquery.

DirtyForm was heavily influenced by the [acvwilson dirty_form](https://github.com/acvwilson/dirty_form) project.