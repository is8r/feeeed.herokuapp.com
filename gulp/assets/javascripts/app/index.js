$(function() {
  // console.log('log');

  $( document ).on('ready page:load', function() {
    $('.js-dropdown-trigger', '.topbar').on('click', function(e) {
      e.preventDefault();
      var $el = $(e.currentTarget);
      var $target = $('.js-topbar');
      if($el.hasClass('is-open')) {
        $el.removeClass('is-open');
        $target.removeClass('is-open');
      } else {
        $el.addClass('is-open');
        $target.addClass('is-open');
      }
    });
  });

});
