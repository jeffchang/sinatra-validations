$(document).ready(function () {

  setTimeout(function() {
  	$('#myModal').reveal().trigger('click');
  }, 10);
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });
  new datepickr('datepick', {
	'fullCurrentMonth': false,
	'dateFormat': 'F jS, Y'
});

});