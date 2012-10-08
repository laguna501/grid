//= require jquery.isotope.js
//= require waypoints.js
//= require bootstrap.js

Grids = {
  layout: function() {
    Grids.changeLayoutMode($(this).attr("data-option-value"));
  },
  filter: function() {
    var nickname = $( this ).attr('data-option-value');
    if(nickname == '*')
      $('#container').isotope({ filter: '*' });
    else
      $('#container').isotope({ filter: '[owner="'+nickname+'"], [class="item"]' });
    return false;
  },
  changeLayoutMode: function(mode){
    $('#container').imagesLoaded( function(){
      $('#container').isotope({
        // options
        itemSelector : '.item',
        layoutMode : mode
      });
    });
  },
  clearUser: function(){
    $('#container').isotope({ filter: '*' });
  },
  allUser: function(){
    Grids.clearUser();
  },
  facebookUser: function(){
    Grids.clearUser();
    $(this).addClass('checked');
  },
  loadNextPhotos: function(page){
    var type = $("#type").val();
    $.ajax({
      url: '/grids/infinite_scroll',
      data: { type: type, page: page },
      type: 'get',
      dataType: 'html',
      success: function(result) {
        $(result).imagesLoaded(function(){
          $('nav.entry').remove();
          $('#current_page').remove();
          $('#container').isotope( 'insert', $(result) );
          setTimeout(function () {
            $('#container').isotope({ filter: '*' });
            $("div.isotope-item").unbind("mouseover");
            $("div.isotope-item").unbind("mouseout");
            $("div.isotope-item").mouseover(function(){
              $(this).children(".infos")show();
              $(this).children("a").children("img").removeClass().addClass("img-fade");
            }).mouseout(function(){
              $(this).children(".infos")hide();
              $(this).children("a").children("img").removeClass();
            });
          }, 300);
        })
      }
    });
  },
  loadWayPoint: function(){
    var $loading = $("<div class='loading'></div>"),
    $entry = $('footer'),
    opts = {
      offset: '100%'
    };

    $entry.waypoint(function(event, direction) {
      $entry.waypoint('remove');
      $('body').append($loading);
      $.get($('.more a').attr('href'), function(data) {
        var $data = $(data);

        var page = $("#current_page").val();
        Grids.loadNextPhotos(page);

        $loading.detach();
        $('.more').replaceWith($data.find('.more'));

        $('#container').imagesLoaded(function(){
          $entry.waypoint(opts);
        });
      });
    }, opts);
  },
  init: function() {
    var page = $("#current_page").val();

    (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=135259466618586";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    Grids.changeLayoutMode('masonry');
    $('#container').isotope({ filter: '*' });
    $('div.layouts').click(Grids.layout);
    $('div.filters').click(Grids.filter);
    $('[id^=username]').click(Grids.facebookUser);
    $('#show-all-user').click(Grids.allUser);

    if(window.location.pathname == "/grids/show_users"){
      Grids.loadNextPhotos(page);
      Grids.loadWayPoint();
    }
  }
}

$(Grids.init);
