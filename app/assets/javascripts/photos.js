//= require jquery.isotope.js

Photos = {
  selectAll: function() {
  	$("input.batch_box").attr("checked", "checked");
  },
  reset: function() {
  	$("input.batch_box").removeAttr("checked");
  },
  highlightManage: function(){
    if($(this).hasClass("unhighlight")){
      $(this).removeClass("unhighlight");
      $(this).addClass("highlighted");
      $(this).parent(".photo_item").addClass("corner-stamp");

      var photo_identifier = $(this).parent(".photo_item").attr("identifier");
      Photos.ajaxUpdateHighlighted(true, photo_identifier, $(this));
    }
    else if($(this).hasClass("highlighted")){
      $(this).removeClass("highlighted");
      $(this).addClass("unhighlight");
      $(this).parent(".photo_item").removeClass("corner-stamp");

      var photo_identifier = $(this).parent(".photo_item").attr("identifier");
      Photos.ajaxUpdateHighlighted(false, photo_identifier, $(this));
    }
    $("#container").isotope('updateSortData', $(this).parent('photo_item') );
    $("#container").isotope();
  },
  loadIsotope: function(){
    $('#container').imagesLoaded( function(){
      $('#container').isotope({
        itemSelector: '.photo_item',
        layoutMode : 'fitRows',
        fitRows: {
          columnWidth: 387,
          cornerStampSelector: '.corner-stamp'
        }
      });
    });
  },
  ajaxUpdateHighlighted: function(flag, photo_identifier, obj){
    $.ajax({
        url: '/photos/change_highlight',
        data: { highlight: flag , identifier: photo_identifier},
        type: 'get',
        success: function() {
          obj.attr("highlighted", flag);
        }
      });
  },
  init: function() {
    $("#select_all").click(Photos.selectAll);
    $("#reset").click(Photos.reset);
    $("div.highlight_button").click(Photos.highlightManage);
    Photos.loadIsotope();
  }
}

$(Photos.init);
