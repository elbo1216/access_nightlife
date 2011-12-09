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
	for (var i=0; i<total_event_ids; i++) {
   if (jQuery('#main_event_container_' + i).is(":visible")) {
     jQuery('#main_event_container_' + i).hide(); 
   }
 }
 jQuery('#main_event_container_' + event_id).fadeIn('fast');
}

function submitNewsletter() {
  var bday = jQuery('#birthday_mon').val() + '/' + jQuery('#birthday_dy').val() + '/' + jQuery('#birthday_yr').val();
  var email = jQuery('#email_address').val();

  if (email == '') {
    alert("Please enter an email address");
    return;
  }

  if (bday.search(/\d\d\/\d\d\/\d\d/) == -1) {
    alert("Please fill in your Birthday");
    return;
  }

  jQuery.ajax({ url: "/request_newsletter",
                type: "POST",
                data: {"email_address": email, "birthday": bday},
                success: function(data) {
                  if (data == "foo") {
                    var overlay = jQuery("#overlay")
                    overlay.html("");
                    overlay.height(jQuery(document).height())
                           .width(jQuery(document).width())
                           .css('text-align', 'center')
                           .css('z-index', '10000')
                           .click(function() { jQuery(this).hide()});
                    
                    var img = jQuery('<div/>')
                                 .css('background-image', 'url("/images/popup.png")')
                                 .css('background-repeat', 'no-repeat')
                                 .css('padding', '25px 2px')
                                 .css('margin', '200px auto')
                                 .width(272)
                                 .height(140)
                                 .html('<span style="width:200px">Thank you for registering to our newsletter.  We will inform you of any new events we may have throughout the year</span>')
                                 .appendTo(overlay);
                    overlay.show();              
                  }
                }
              });
}

var MediaSetup={
  container:"#media_content_container",
  init:function(type) {
    jQuery('#left_selector').click(function() { MediaSetup.slideContainer("left")});
    jQuery('#left_selector').mouseover( function() { jQuery(this).css("cursor","pointer") });
    jQuery('#right_selector').click(function() { MediaSetup.slideContainer("right")});
    jQuery('#right_selector').mouseover( function() { jQuery(this).css("cursor","pointer") });
    this.setULSize();
    this.configureSelectors();
    if (type == 'Galleries') {
      this.setupGalleryLinks();
    }

    if (type == 'Images') {
      this.setupImageLinks();
      jQuery('#overlay').click(function() { jQuery(this).hide() });
    }
  },
  
  slideContainer:function(direction) {
    jQuery(this.container + ' ul').each (function() {
      var margin = parseInt(jQuery(this).css("marginLeft"));
        if (direction == 'left') {
          margin += 240;
        } else {
          margin -= 240;
        }
      jQuery(this).animate({"marginLeft": margin + "px"}, {duration: "slow", complete: function() {MediaSetup.configureSelectors()}});
    })
  },

  configureSelectors:function() {
    var ul = jQuery(jQuery(this.container + ' ul')[0]);
    var content_width = jQuery(this.container).width();
    if (parseInt(ul.css('marginLeft')) + ul.width() <= content_width) {
      jQuery('#right_selector').css("background", "");
    } else {
      jQuery('#right_selector').css("background", "url('/images/sprite.png') -351px -298px");
    }

    if (parseInt(ul.css('marginLeft')) == 0) {
      jQuery('#left_selector').css("background", "");
    } else {
      jQuery('#left_selector').css("background", "url('/images/sprite.png') -280px -298px");
    }
  },

  setULSize:function() {
    var width = 0;
    var ul = jQuery(jQuery(this.container + ' ul')[0]);
    ul.find("li").each(function() { width += jQuery(this).width() })
    ul.width(width);
  },

  setupGalleryLinks:function() {
    var galleries = jQuery(this.container + ' .media_content')
    for(var i=0;i<galleries.length;i++) {
      jQuery(galleries[i]).mouseover( function() { jQuery(this).css('cursor', 'pointer')});
      jQuery(galleries[i]).click( function() {
        window.location.href = '/media_images?id=' + jQuery(this).attr('id').substr(8, jQuery(this).attr('id').length -1);
      })
    }
  },

  setupImageLinks:function() {
    var images = jQuery(this.container + ' .media_content')
    for(var i=0;i<images.length;i++) {
      jQuery(images[i]).mouseover(function() { jQuery(this).css('cursor', 'pointer') });
      jQuery(images[i]).click( function () {
        var overlay = jQuery('#overlay');
        height = jQuery(document).height();
        overlay.html("")
               .height(height)
               .css('text-align', 'center');
        var img = jQuery('<img/>')
              .attr('src', jQuery(jQuery(this).find('img')[0]).attr('src'))
              .css('margin', 'auto')
              .css('border', 'solid 2px white')
              .appendTo(overlay);
        overlay.show();
        // Need to recalc the margin top for the image 
        img.css('margin-top', (height - img.height())/2);
      })
    }
  }
}
