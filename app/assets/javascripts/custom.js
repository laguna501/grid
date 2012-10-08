Custom = {
  init: function() {
    $("div.isotope-item").mouseover(function(){
      $(this).children(".infos").removeClass().addClass("infos show");
      $(this).children("a").children("img").removeClass().addClass("img-fade");
    }).mouseout(function(){
      $(this).children(".infos").removeClass().addClass("infos");
      $(this).children("a").children("img").removeClass();
    });
  }
}

$(Custom.init);
