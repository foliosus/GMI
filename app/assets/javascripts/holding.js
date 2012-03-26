jQuery(function($) {
  $('a.button').click(function() {
    $(this).slideUp();
    $('#contact_information').slideDown();
  });
  
  $('#contact_form form')
    .live('ajax:beforeSend', function() {
      $(this).find('button').attr('disabled', 'disabled').text('Sending...');
    })
    .live('ajax:error', function() {
      $(this).find('button').text('Send it!').removeAttr('disabled');
    })
    .live('ajax:complete', function(data, status, xhr) {
      $('#contact_form').fadeOut('fast', function() {
        $(this).html(status.responseText).fadeIn('normal');
      })
      $('p.response').pulse();
    });
});