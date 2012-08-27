//= require jquery.isotope.min.js

Grids = {
  layout: function() {
    Grids.changeLayoutMode($(this).attr("data-option-value"));
  },
  changeLayoutMode: function(mode){
    $('#container').isotope({
      // options
      itemSelector : '.item',
      layoutMode : mode,
      // sortBy : 'random'
    });
  },
  init: function() {
    Grids.changeLayoutMode('fitRows');
    $('div.layouts').click(Grids.layout);

    (function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=135259466618586";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

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
