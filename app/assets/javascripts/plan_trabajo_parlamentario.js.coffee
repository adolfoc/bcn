# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(function() {
	$( "#restrict_person").click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			alert("Checked");
		else
			alert("Unchecked");
	})
});
