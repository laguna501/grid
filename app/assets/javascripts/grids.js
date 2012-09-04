//= require jquery.isotope.js

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
  init: function() {
    Grids.changeLayoutMode('masonry');
    $('div.layouts').click(Grids.layout);
    $('div.filters').click(Grids.filter);

    (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=135259466618586";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
  }
}

$(Grids.init);
