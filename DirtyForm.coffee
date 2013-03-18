define (require) ->

	require('jquery')

	class DirtyForm
		constructor: (options) ->
			@settings = $.extend({}, options)
			form = @settings.form

			# reset everything if necessary
			if form.hasClass('dirtyform')
				form.off('dirty')
					.off('clean')
					.off('.dirtyform')
			else
				form.addClass('dirtyform')

			inputs = $(':input:not(:submit,:password,:button)', form)

			# Setup checkboxes and select elements for change events
			changeElements = inputs.filter(':radio,:checkbox,select')
			form.on('change.dirtyform', ':radio,:checkbox,select', {inputs: changeElements}, @inputChecker)
			changeElements.each (itr, elem) =>
				input = $(elem)
				input.data('initial', @getValue(input))

			# Setup everything else for keyup
			allElse = inputs.not(':radio,:checkbox,select')
			form.on('keyup.dirtyform', ':input:not(:submit,:password,:button,:radio,:checkbox,select)', {inputs: allElse}, @inputChecker)
			allElse.each (itr, elem) =>
				input = $(elem)
				input.data('initial', @getValue(input))

			if @settings.both
				form.on('clean dirty', @settings.both)
			else
				if @settings.clean
					form.on('clean', @settings.clean)
				if @settings.dirty
					form.on('dirty', @settings.dirty)

		getValue: (input) ->
			if input.is(':radio,checkbox')
				input.prop('checked')
			else
				input.val()

		inputChecker: (event) =>
			npt = $(event.target)
			form = npt.parents('.dirtyform')
			initial = npt.data('initial')
			current = @getValue(npt)
			inputs = event.data.inputs

			if initial != current
				npt.addClass('changed')
			else
				npt.removeClass('changed')

			@isDirty = inputs.filter('.changed').length > 0

			vals =
				from: initial
				to: current
				target: npt
				event: event
				isDirty: @isDirty

			if @isDirty
				form.data('dirty', true).trigger('dirty', vals)
			else
				form.data('dirty', false).trigger('clean', vals)
