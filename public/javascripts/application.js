// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function submitUserInfo() {
	document.getElementById('overlay').style.display='block';
	document.getElementById('first_name').value = '';
	document.getElementById('last_name').value = '';
	document.getElementById('email_address').value = '';
	document.getElementById('phone_number').value = '';
	document.getElementById('birthday_mon').value = '';
	document.getElementById('birthday_dy').value = '';
	document.getElementById('birthday_yr').value = '';
}

function toggleEvent(event_id, total_event_ids) {
	jQuery.noConflict();
	for (i=0; i<total_event_ids; i++) {
      if (jQuery('#main_event_container_' + i).is(":visible")) {
        jQuery('#main_event_container_' + i).hide(); 
	  }
    }
    jQuery('#main_event_container_' + event_id).fadeIn('fast');
}
