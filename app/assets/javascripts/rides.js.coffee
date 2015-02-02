$ ->
	$('.panel-body').last().on('ajax:success', (data, status, xhr) ->
		$(@).html("You've been added to the carpool.")
		null
		)