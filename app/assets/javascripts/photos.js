Photos = {
  checkItem: function() {
    var is_checked = $(this).find(".batch_box").attr("checked") == "checked";
    alert(is_checked);
    $(this).find(".batch_box").attr("checked", !is_checked);
  },
  init: function() {
    // $("div.photo_item").click(Photos.checkItem);
  }
}

$(Photos.init);
