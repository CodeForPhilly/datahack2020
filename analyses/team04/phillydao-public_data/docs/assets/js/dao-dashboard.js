// submenu dropdown
$(document).ready(function(){
  $('.dropdown-submenu a.test').on("click", function(e){
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
  });
});

// hide the submenu when the main menu button is clicked
$('.dropdown-toggle.btn.btn-dao-menu').on("click", function(e){
    $('.dropdown-submenu a.test').next('ul').hide();
});

// handle tag switching for collapsible table icons
$(function(){
  $('tr').on('click', function(e){
    var trow = $(e.currentTarget);
    if(trow.attr('aria-expanded') === 'true') {
      $(this).attr('aria-expanded', 'false');
    } else {
      $(this).attr('aria-expanded', 'true')
    }
  })
})