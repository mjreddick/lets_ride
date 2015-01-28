 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://coffeescript.org/


$(function() {
	$('#search-button').click(sendSearch)
});

function sendSearch() {
	var keywords = $('#keyword-input').val();
	var location = $('#location-input').val();
	var eventSearchArgs = {
	    app_key:"SRKGJkZQjmzT9fzZ",
	    keywords: keywords,
	    location: location,
	    date: "Future",
	    image_sizes: ["medium"],
	    page_size: 6,
	    page_number: 1
		};

	$('#home-title').hide();
	$('#results-container').html("");
	$('#keyword-input').parent('div').removeClass().addClass("col-sm-4");
	$('#location-input').parent('div').removeClass().addClass("col-sm-4");
	$('#search-button').parent('div').removeClass().addClass("col-sm-4");
	EVDB.API.call("/events/search", eventSearchArgs, searchResultsReceived);
	// maybe disable button
	// perhaps start an animation to let user know search is happening


}

function searchResultsReceived(eventData) {
	// enable button again
	// populate a list of results or something...
	$('#home-title').hide();
	var container = $('#results-container');

	console.log(eventData);
	var eventArray = eventData.events.event;
	console.log(eventArray)
	
	for(var i = 0; i < eventArray.length; i++) {
		container.append(createEventBox(eventArray[i], i));
		container.append(createEventModal(eventArray[i], i))
	}
}

function createEventBox(event, i){
	var eventBox = '<div class="col-sm-4"><div class="event-box" data-toggle="modal" data-target="';
	// add the modal name for this event
	eventBox += '#modal_' + i + '">';
	eventBox += '<img  class="event-image img-responsive" width="128" height="128" src="';
	// add the image provided or a default image if one isn't provided
	if(event.image && event.image.medium && event.image.medium.url) {
		eventBox += 	event.image.medium.url;
	}
	else {
		eventBox += "http://www.homelesshouston.org/wp-content/uploads/2012/09/blank_test-200x200.png";
	}

	eventBox += '""><div class="event-box-text">';
	eventBox += '<p>' + event.title + '</p>';
	eventBox += '<p>' + event.venue_name + '</p>';
	eventBox += '<p>' + event.start_time + '</p>';
	eventBox += '</div></div></div>';
	
	return eventBox;
	
}

function createEventModal(event, i){
	var modal = '<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="';
	// add modal name for this event
	modal += 'modal_' + i + '">';
	modal += '<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title">';
	modal += event.title + '</h4></div><div class="modal-body">';
	// add modal content
	modal += 'Some Stuff';
	modal += '</div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button><button type="button" class="btn btn-primary">Save changes</button></div></div></div></div>';
	return modal;
}