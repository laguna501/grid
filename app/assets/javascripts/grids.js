//= require jquery.isotope.js
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
    $('#container').isotope({
      // options
      itemSelector : '.item',
      layoutMode : mode,
      sortBy : 'random'
    });
  },
  allUser: function(){
    Grids.clearUser();
  },
  facebookUser: function(){
    Grids.clearUser();
    $(this).addClass('checked');
  },
  clearUser: function(){
    $('[id^=username]').removeClass('checked');
  },
  init: function() {
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
    setTimeout(function() {$('#show-all-user').click() }, 800);
  }
}

$(Grids.init);
