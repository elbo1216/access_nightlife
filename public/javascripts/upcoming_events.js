function toggleEvent(event_id, total_event_ids) {
	jQuery.noConflict();
	for (i=0; i<total_event_ids; i++) {
      if (jQuery('#main_event_container_' + i).is(":visible")) {
        jQuery('#main_event_container_' + i).hide(); 
	  }
    }
    jQuery('#main_event_container_' + event_id).fadeIn('fast');
}
