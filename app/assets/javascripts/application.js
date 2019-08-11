// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

function toggleVisibility(id) {
      alert("From headquarters!");
          var x = document.getElementById(id);
          if (x.style.display === "none") {
            x.style.display = "inline";
          } else {
            x.style.display = "none";
          }
        }
//##############new style
        let $cards = $('.cardWrap');

        // Card Closer
        $cards.on('close.bs.alert', function(e) {
          // prevent card from being removed
          e.preventDefault();
          // hide card
          $(this).addClass('hidden');
        });

        // Card Buttons
        $('.cardSelect').on('click', function() {
          let cardIndex = $(this).index();
          if (!cardIndex) {
            // show all cards (overview)
            $cards.removeClass('hidden');
          } else {
            // toggle one card
            $cards.eq(cardIndex - 1).toggleClass('hidden');
          }
        });
