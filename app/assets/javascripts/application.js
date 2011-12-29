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
	initialize_tp_control();
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

	// TP by request
	$( "#tp_parameter_restrict_chamber_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_camara_filter();
		else
			disable_camara_filter();
	})
	$( "#tp_parameter_restrict_date_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_fechas_filter();
		else
			disable_fechas_filter();
	})
	$( "#tp_parameter_restrict_person_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_person_filter();
		else
			disable_person_filter();
	})
	$( "#tp_parameter_free_search_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_search_area_filter();
		else
			disable_search_area_filter();
	})
	$( "#tp_parameter_taxonomy_search_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_taxonomy_filter();
		else
			disable_taxonomy_filter();
	})
	$( "#tp_parameter_restrict_ds_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_ds_filter();
		else
			disable_ds_filter();
	})
	$( "#tp_parameter_restrict_law_enabled" ).click (function() {
		var thisCheck = $(this);
		if (thisCheck.is (':checked'))
			enable_law_filter();
		else
			disable_law_filter();
	})
});

function initialize_tp_control() {
	if ($( "#new_tp_parameter" ).length) {
		enable_camara_filter();
		check_camara_filter();
		disable_fechas_filter();
		disable_person_filter();
		disable_search_area_filter();
		disable_taxonomy_filter();
		disable_ds_filter();
		disable_law_filter();
	}
}

function check_camara_filter() {
	$("#tp_parameter_restrict_chamber_enabled").prop("checked", true);
}

function uncheck_camara_filter() {
	$("#tp_parameter_restrict_chamber_enabled").prop("checked", false);
}

function enable_camara_filter() {
	$("#tp_parameter_organism_id").removeAttr("disabled");
	$("#tp_parameter_legislature_id").removeAttr("disabled");
	$("#tp_parameter_session_id").removeAttr("disabled");
}

function disable_camara_filter() {
	$("#tp_parameter_organism_id").attr("disabled", true);
	$("#tp_parameter_legislature_id").attr("disabled", true);
	$("#tp_parameter_session_id").attr("disabled", true);
}

function enable_fechas_filter() {
	$("#tp_parameter_from_date_1i").removeAttr("disabled");
	$("#tp_parameter_from_date_2i").removeAttr("disabled");
	$("#tp_parameter_from_date_3i").removeAttr("disabled");
	$("#tp_parameter_to_date_1i").removeAttr("disabled");
	$("#tp_parameter_to_date_2i").removeAttr("disabled");
	$("#tp_parameter_to_date_3i").removeAttr("disabled");
}

function disable_fechas_filter() {
	$("#tp_parameter_from_date_1i").attr("disabled", true);
	$("#tp_parameter_from_date_2i").attr("disabled", true);
	$("#tp_parameter_from_date_3i").attr("disabled", true);
	$("#tp_parameter_to_date_1i").attr("disabled", true);
	$("#tp_parameter_to_date_2i").attr("disabled", true);
	$("#tp_parameter_to_date_3i").attr("disabled", true);
}

function enable_person_filter() {
	$("#tp_parameter_party_id").removeAttr("disabled");
	$("#tp_parameter_person_id").removeAttr("disabled");
	$("#tp_parameter_participation_type_id").removeAttr("disabled");
	$("#tp_parameter_quality_type_id").removeAttr("disabled");
}

function disable_person_filter() {
	$("#tp_parameter_party_id").attr("disabled", true);
	$("#tp_parameter_person_id").attr("disabled", true);
	$("#tp_parameter_participation_type_id").attr("disabled", true);
	$("#tp_parameter_quality_type_id").attr("disabled", true);
}

function enable_search_area_filter() {
	$("#tp_parameter_free_search_text").removeAttr("disabled");
}

function disable_search_area_filter() {
	$("#tp_parameter_free_search_text").attr("disabled", true);
}

function enable_taxonomy_filter() {
	$("#tp_parameter_taxonomy_category_id").removeAttr("disabled");
	$("#tp_parameter_taxonomy_term_id").removeAttr("disabled");
}

function disable_taxonomy_filter() {
	$("#tp_parameter_taxonomy_category_id").attr("disabled", true);
	$("#tp_parameter_taxonomy_term_id").attr("disabled", true);
}

function enable_ds_filter() {
	$("#tp_parameter_ds_part_id").removeAttr("disabled");
	$("#tp_parameter_ds_page").removeAttr("disabled");
	$("#tp_parameter_ds_tome").removeAttr("disabled");
}

function disable_ds_filter() {
	$("#tp_parameter_ds_part_id").attr("disabled", true);
	$("#tp_parameter_ds_page").attr("disabled", true);
	$("#tp_parameter_ds_tome").attr("disabled", true);
}

function enable_law_filter() {
	$("#tp_parameter_bill").removeAttr("disabled");
	$("#tp_parameter_law").removeAttr("disabled");
}

function disable_law_filter() {
	$("#tp_parameter_bill").attr("disabled", true);
	$("#tp_parameter_law").attr("disabled", true);
}
