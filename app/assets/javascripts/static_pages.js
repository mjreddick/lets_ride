 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://coffeescript.org/

var DEFAULT_IMAGE_URL = 'https://s3-us-west-1.amazonaws.com/lets-ride/default-icon.png';
var events = [];

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
	// clear old events
	events = [];
	// enable button again
	$('#search-button').removeClass("disabled")
	$('#loading-spinner').hide();
	$('#home-title').hide();
	var container = $('#results-container');

	console.log(eventData);
	var eventArray = eventData.events.event;
	console.log(eventArray)
	
	// put the search results in an easy to use format
	for(var i =0; i < eventArray.length; i++){
		var event = {};
		var currentEvent = eventArray[i];
		
		event.title = currentEvent.title;
		event.details = currentEvent.description;
		event.starDateTime = currentEvent.start_time;

		// format the date_time for easy use
		var dateTime = new Date(event.starDateTime);
		event.formattedDateTime = dateTime.toDateString();

		event.venueName = currentEvent.venue_name;
		event.id = currentEvent.id;

		if(currentEvent.image && currentEvent.image.medium && currentEvent.image.medium.url) {
			event.mediumImage = 	currentEvent.image.medium.url;
		}
		else {
			event.mediumImage = DEFAULT_IMAGE_URL;
		}

		if(currentEvent.image && currentEvent.image.large && currentEvent.image.large.url) {
			event.largeImage = 	currentEvent.image.large.url;
		}
		else {
			event.largeImage = DEFAULT_IMAGE_URL;
		}

		events.push(event);

	}

	for(var i = 0; i < eventArray.length; i++) {
		container.append(createEventBox(events[i], i));
		container.append(createEventModal(events[i], i))
	}
	$('.drive-btn').click(chooseDrive);
	$('.ride-btn').click(chooseRide);
}

function createEventBox(event, i){

	var eventBox = '<div class="col-sm-4"><div class="event-box" data-toggle="modal" data-target="';
	// add the modal name for this event
	eventBox += '#modal_' + i + '">';
	eventBox += '<img  class="event-image img-responsive" width="128" height="128" src="';

	eventBox += event.mediumImage;

	eventBox += '"><div class="event-box-text">';
	eventBox += '<p><span class="event-box-title">' + formattedTitle(event.title) + '</span></p>';
	eventBox += '<p>' + event.formattedDateTime + '</p>';
	eventBox += '</div></div></div>';
	
	return eventBox;
	
}

function createEventModal(event, i){

	var modal = '<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="';
	// add modal name for this event
	modal += 'modal_' + i + '">';
	modal += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title">';
	modal += '<strong>' + event.title + '</strong></h4></div><div class="modal-body">';
	
	// add hidden event info to be used to create rides
	modal += '<div class="hidden event-index">' + i + '</div>';

	// add modal content
	// add event picture
	modal += '<img  class="large-event-image img-responsive" width="480" height="480" src="';
	modal += event.largeImage;
	modal += '">';
	
	modal += '<p>' + event.venueName + '</p>';
	modal += '<p>' + event.formattedDateTime + '</p>';
	if(event.details) {
		modal += '<p>' + event.details + '</p>';
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

		// get the event associated with the modal
		var index = modal.find('.event-index').html();
		var event = events[index];

		// insert all the needed event values into the create ride modal
		$('#event_eventful_id').val(event.id);
		$('#event_image_url_medium').val(event.mediumImage);
		$('#event_image_url_large').val(event.largeImage);
		$('#event_title').val(event.title);
		$('#event_details').val(event.details);
		$('#event_start_date_time').val(event.starDateTime);
		$('#event_venue_name').val(event.venueName);

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
	// get the zipcode from the zipcode modal
	var zipcode = $('#zipcodeInput').val();

	// get the eventful_id from the new ride modal
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
