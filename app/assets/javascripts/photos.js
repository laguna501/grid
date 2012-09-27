Photos = {
  checkItem: function() {
    var is_checked = $(this).find(".batch_box").attr("checked") == "checked";
    alert(is_checked);
    $(this).find(".batch_box").attr("checked", !is_checked);
  },
  selectAll: function() {
  	$("input.batch_box").attr("checked", "checked");
  },
  reset: function() {
  	$("input.batch_box").removeAttr("checked");
  },
  init: function() {
    // $("div.photo_item").click(Photos.checkItem);
    $("#select_all").click(Photos.selectAll);
    $("#reset").click(Photos.reset);
  }
}

$(Photos.init);
