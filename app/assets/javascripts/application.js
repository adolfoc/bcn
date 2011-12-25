// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
$(function() {
	var active_section = parseInt($('meta[name=accordion_section]').attr('content'));
	var options = {
		active: active_section,
		autoHeight: false
	}
	$("#menu-accordion" ).accordion(options);
	$( "#ot-tabs" ).tabs();
	// Filters
	$( "#show-button-incoming" ).click(function() {
		var selectedEffect = "blind";
		var effect_options = {};
		$( "#ot-filter-incoming" ).toggle(selectedEffect, effect_options, 500);
		return false;
	})
	$( "#show-button-work" ).click(function() {
		var selectedEffect = "blind";
		var effect_options = {};
		$( "#ot-filter-work" ).toggle(selectedEffect, effect_options, 500);
		return false;
	})
	$( "#show-button-sent" ).click(function() {
		var selectedEffect = "blind";
		var effect_options = {};
		$( "#ot-filter-sent" ).toggle(selectedEffect, effect_options, 500);
		return false;
	})
	$( "#restrict_person").click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_person_filter();
		else
			disable_person_filter();
	})
});

function enable_person_filter() {
	$("#parameters_bancada").removeAttr("disabled");
	$("#parameters_person").removeAttr("disabled");
	$("#parameters_participation_type").removeAttr("disabled");
	$("#parameters_participation_quality").removeAttr("disabled");
}

function disable_person_filter() {
	$("#parameters_bancada").attr("disabled", true);
	$("#parameters_person").attr("disabled", true);
	$("#parameters_participation_type").attr("disabled", true);
	$("#parameters_participation_quality").attr("disabled", true);
}
