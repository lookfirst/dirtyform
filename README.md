DirtyForm
=========

Good UX design dictates that a ```Save``` button is disabled until something changes or the data within a form is valid. This little class makes it easy to implement.

Usage
-----

Define a container to watch for changes in. If any form element (select, input, textarea, etc.) values within the container are modified from their original state, a ```dirty``` function is called. If all of the elements return to their original state, then the ```clean``` function is called.

There is also a ```both``` function which will be called in either case and it is possible to check if things are dirty or not with ```dirtyForm.isDirty```.

Contrived example to get the point across
-----------------------------------------

``` html

<div id="formdiv">
    <input type="text" name="name" id="name" />
    <input type="text" name="age" id="age" />
    <input type="submit" id="saveButton" disabled="disabled" class="btn disabled" />
</div>
```

``` coffeescript

DirtyForm = require('app/DirtyForm')

formdiv = $('#formdiv')
saveButton = $('#saveButton', formdiv)

enableButton = (obj) ->
    obj.removeClass('disabled').removeAttr('disabled') if obj

disableButton = (obj) ->
    obj.addClass('disabled').attr('disabled', 'disabled') if obj

validate = (event, data) ->
    if df.isDirty && $('#name', formdiv).val() && $('#age', formdiv).val() > 10
        enableButton(saveButton)
    else
        disableButton(saveButton)

df = new DirtyForm
    form: formdiv
    both: (event, data) ->
        validate(event, data)
```

Etc
---

The DirtyForm class is wrapped in [```simplified CommonJS wrapping```](http://requirejs.org/docs/whyamd.html#sugar) because that is what I use for my site.

DirtyForm depends on a recent version of jquery.

DirtyForm was heavily influenced by the [acvwilson dirty_form](https://github.com/acvwilson/dirty_form) project.