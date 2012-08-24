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
  }
}

$(Grids.init);
