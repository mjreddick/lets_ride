$(function() {
	$('.notification-close').click(closeNotification);
	$('.ride-accept').click(updateRequest);
});

function closeNotification() {
	var notificationID = $(this).data('id');
	// Make the DELETE request! Upon success, do nothing.
	var request = $.ajax({
		dataType: 'json',
		type: 'DELETE',
		url: '/api/notifications/' + notificationID,
		data: {approval: true}
	});

	request.done( function (){
		console.log("delete success");
	});
	request.fail(function(){
		console.log("delete failed");
	});
	request.always(function() {
	});
}


function updateRequest(){
	var requestID = $(this).data('id');
	var accepted = $(this).data('accepted');

	var request = $.ajax({
		dataType: 'json',
		type: 'PUT',
		url: '/api/requests/' + requestID,
		data: {accepted: accepted}
	});

	$(this).parents('.approval-notification').fadeOut();

	request.done( function (){
		console.log("update success");
	});
	request.fail(function(){
		console.log("update failed");
	});
	request.always(function() {
		
	});

}