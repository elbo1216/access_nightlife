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
