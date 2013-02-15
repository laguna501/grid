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
  filterSource: function(){
    var photosource = $( this ).attr('data-option-value');
    if (photosource == 'facebook')
      $('#container').isotope ({ filter: '.item.facebook'});
    else
      $('#container').isotope ({ filter: '.item.instagram'});
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
    $('div.filters').find('button').removeClass('checked');
    $('#container').isotope({ filter: '*' });
  },
  allUser: function(){
    window.location = "/grids/show_users?type=" + $(this).attr("data-user-type");
  },
  filterUser: function(){
    window.location = "/grids/" + $(this).attr("data-user-id");
  },

  loadNextPhotos: function(page){
    if(current_page == page){
      return;
    }
    current_page = page;
    var type = $("#type").val();
    var user = $("#user").val();
    $.ajax({
      url: '/grids/infinite_scroll',
      data: { type: type, page: page, user: user },
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
              $(this).children(".infos").show();
              $(this).children("a").children("img").css({
                'opacity':0.7,
                'background-color':'#fff',
                '-webkit-transition': 'all 0.4s ease-in-out',
                '-moz-transition': 'all 0.4s ease-in-out',
                '-o-transition': 'all 0.4s ease-in-out',
                '-ms-transition': 'all 0.4s ease-in-out',
                'transition': 'all 0.4s ease-in-out'
              });
            }).mouseout(function(){
              $(this).children(".infos").hide();
              $(this).children("a").children("img").css({
                'opacity':1,
                'background-color':'#fff',
                '-webkit-transition': 'all 0.4s ease-in-out',
                '-moz-transition': 'all 0.4s ease-in-out',
                '-o-transition': 'all 0.4s ease-in-out',
                '-ms-transition': 'all 0.4s ease-in-out',
                'transition': 'all 0.4s ease-in-out'
              });
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

  loadFancybox: function(){
    $(document).ready(function() {
    $("a.photo").fancybox({
        fitToView : true,
        openEffect  : 'none',
        closeEffect : 'none',
        nextEffect  : 'none',
        prevEffect  : 'none',
        padding     : 0,
        margin      : [20, 60, 20, 60]
        });


     });
  },


  init: function() {
    var current_page = null;
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
    $('[id^=username]').click(Grids.filterUser);
    $('#show-all-user').click(Grids.allUser);
    $('div.filtersource').click(Grids.filterSource);
    $("#CaptionHide").click(function () {
      $("#photo_caption").slideToggle("slow");
    });


    if(window.location.pathname.match(/grids\/\S+/)){
      Grids.loadNextPhotos(page);
      Grids.loadWayPoint();
      Grids.loadFancybox();
    }
  }
}


$(Grids.init);

