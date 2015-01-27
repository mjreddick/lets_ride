 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://coffeescript.org/


$(function() {
	$('#search-button').on('click', sendSearch)
});

function sendSearch() {
	var keywords = $('#keyword-input').val();
	var location = $('#location-input').val();
	var eventSearchArgs = {
	    app_key:"SRKGJkZQjmzT9fzZ",
	    keywords: keywords,
	    location: location,
	    date: "Future",
	    image_sizes: ["block200"],
	    page_size: 6,
	    page_number: 1
		};

	EVDB.API.call("/events/search", eventSearchArgs, searchResultsReceived);
	// maybe disable button
	// perhaps start an animation to let user know search is happening
}

function searchResultsReceived(eventData) {
	// enable button again
	// populate a list of results or something...
	var container = $('#results-container');

	console.log(eventData);
	var eventArray = eventData.events.event;
	console.log(eventArray)
	
	for(var i = 0; i < eventArray.length; i++) {
		container.append(createEventBox(eventArray[i], i));
		// container.append(createEventModal(eventArray[i], i))
	}
}

function createEventBox(event, i){
	var s;
	try {
		s = '<div class="col-md-4"><img src="'+ event.image.block200.url +'"></div>'; 
	}
	catch (e) {
		s = '<div class="col-md-4"></div>'; 
	}
	return s;
	
}

function createEventModal(event, i){

}