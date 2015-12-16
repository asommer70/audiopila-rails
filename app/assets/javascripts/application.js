// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require_tree .
//= require chosen.jquery
//= require html.sortable
//= require jquery.pjax

$(function(){
  $(document).foundation();

  // Setup pjax to load everything but the global player.
  $(document).pjax('a', '#pjax');

  $(document).on('pjax:complete', function(event, xhr, status, options) {
    // Remove current active nav class.
    $('.active').toggleClass('active');

    // Add active to current nav.
    switch (window.location.pathname) {
      case '/albums':
        $('.albums').toggleClass('active')
        break;
      case '/audios':
        $('.audios').toggleClass('active')
        break;
      case '/playlists':
        $('.playlists').toggleClass('active')
        break;
      case '/settings':
        $('.settings').toggleClass('active')
        break;
    }
  })
});
