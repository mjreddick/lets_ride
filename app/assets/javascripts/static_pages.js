 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://coffeescript.org/

var DEFAULT_IMAGE_URL = 'https://s3-us-west-1.amazonaws.com/lets-ride/default-icon.png';

$(function() {
	$('#search-button').click(sendSearch)
	$('#look-for-rides').click(lookForRides)
});

function sendSearch() {
	var keywords = $('#keyword-input').val();
	var location = $('#location-input').val();

	// default to LA
	if (location == "") {
		location = "Los Angeles, CA"
	}
	var eventSearchArgs = {
	    app_key:"SRKGJkZQjmzT9fzZ",
	    keywords: keywords,
	    location: location,
	    date: "Future",
	    image_sizes: ["medium", "large"],
	    page_size: 6,
	    page_number: 1
		};

	$('#home-title').hide();
	$('#results-container').html("");
	$('#keyword-input').parent('div').removeClass().addClass("col-sm-4 col-sm-offset-1");
	$('#location-input').parent('div').removeClass().addClass("col-sm-4");
	$('#search-button').parent('div').removeClass().addClass("col-sm-2");
	// disable the search button
	$('#search-button').addClass("disabled");
	$('#loading-spinner').show();
	EVDB.API.call("/events/search", eventSearchArgs, searchResultsReceived);

}

function searchResultsReceived(eventData) {
	// enable button again
	$('#search-button').removeClass("disabled")
	$('#loading-spinner').hide();
	$('#home-title').hide();
	var container = $('#results-container');

	console.log(eventData);
	var eventArray = eventData.events.event;
	console.log(eventArray)
	
	for(var i = 0; i < eventArray.length; i++) {
		container.append(createEventBox(eventArray[i], i));
		container.append(createEventModal(eventArray[i], i))
	}
	$('.drive-btn').click(chooseDrive);
	$('.ride-btn').click(chooseRide);
}

function createEventBox(event, i){
	// get the date/time
	var date_time = new Date(event.start_time);
	date_time = date_time.toDateString();

	var eventBox = '<div class="col-sm-4"><div class="event-box" data-toggle="modal" data-target="';
	// add the modal name for this event
	eventBox += '#modal_' + i + '">';
	eventBox += '<img  class="event-image img-responsive" width="128" height="128" src="';
	// add the image provided or a default image if one isn't provided
	if(event.image && event.image.medium && event.image.medium.url) {
		eventBox += 	event.image.medium.url;
	}
	else {
		eventBox += DEFAULT_IMAGE_URL;
	}

	eventBox += '"><div class="event-box-text">';
	eventBox += '<p><span class="event-box-title">' + formattedTitle(event.title) + '</span></p>';
	eventBox += '<p>' + date_time + '</p>';
	eventBox += '</div></div></div>';
	
	return eventBox;
	
}

function createEventModal(event, i){
	// get the date/time
	var date_time = new Date(event.start_time);
	date_time = date_time.toDateString();

	var modal = '<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="';
	// add modal name for this event
	modal += 'modal_' + i + '">';
	modal += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title">';
	modal += '<strong>' + event.title + '</strong></h4></div><div class="modal-body">';
	// add hidden event info to be used to create ride

	modal += '<div class="hidden event-eventful-id">' + event.id + '</div>';
	// add modal content
	modal += '<img  class="large-event-image img-responsive" width="480" height="480" src="';
	// add the image provided or a default image if one isn't provided
	if(event.image && event.image.large && event.image.large.url) {
		modal += 	event.image.large.url;
	}
	else {
		modal += DEFAULT_IMAGE_URL;
	}
	modal += '">';
	modal += '<p>' + event.venue_name + '</p>';
	modal += '<p>' + date_time + '</p>';
	if(event.description) {
		modal += '<p>' + event.description + '</p>';
	}
	modal += '</div><div class="modal-footer text-center"><button type="button" class="btn btn-default btn-lg ride-btn">Ride</button><button type="button" class="btn btn-primary btn-lg drive-btn">Drive</button></div></div></div></div>';
	return modal;
}

function chooseDrive() {
	var showModal = chooseHelper(this);

	// show the modal to create a ride
	if(showModal){
		$('#newRideModal').modal('show');
	}
}

function chooseRide(){
	var showModal = chooseHelper(this);

	// show the modal to get the user's zipcode
	if(showModal){
		$('#zipcodeModal').modal('show');
	}
}

function chooseHelper(self){

	if($('#logged-in').html() == "true"){
		var modal = $(self).parents('.modal');

		// hide the modal
		modal.modal('hide');

		var id = modal.find('.event-eventful-id').html();

		// console.log(id)
		$('#ride_eventful_id').val(id);

		return true;	
	}
	else {
		window.location.href = "/login";
		return false;
	}
}

// when the Look For Rides button is pressed
// after a user says they want a ride and
// inputs a zipcode
function lookForRides(){
	var zipcode = $('#zipcodeInput').val();
	var eventId = $('#ride_eventful_id').val();
	window.location.href = "/rides?event_ful_id=" + eventId + 
	"&zipcode=" + zipcode;
}

// this makes sure the title isn't too long
// it will cut it off and add ... if it is too long
function formattedTitle(title) {
	var MAX_LENGTH = 43;
	if(title.length >= MAX_LENGTH){
		title = title.slice(0, MAX_LENGTH - 3);

		//try to cut it off at a whole word
		var lastWordIndex = title.lastIndexOf(" ");
		if(lastWordIndex != -1) {
			title = title.slice(0, lastWordIndex);
		}

		title += "...";
	}
	return title;
}
