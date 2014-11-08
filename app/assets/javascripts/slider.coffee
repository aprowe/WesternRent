
selector = '#slider'

$.fn.slider = ($switch) ->
	$(this).appendTo( $(selector) ).hide()

	$switch.click =>
		$(selector).children().hide()
		$(this).show()
		$(selector).slideToggle()

$.fn.close = ()->
	$(this).slideToggle()
	$(selector).children().hide()

$.fn.id = ()->
	$(this).closest('.profile').attr('profile')