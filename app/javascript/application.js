// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "jquery"
import "jquery_ujs"
import "bootstrap"
import "popper"
import * as jq from 'jquery';

$(document).ready(function(){

  $("body").on("click", "button.list-group-item", function(){
    toggleActive($(this), $(this).closest(".list-group").find("button.active")); //navbar($(this))
    var f = setHiddenInputs("input:hidden[name='photo[tags]']", $(this).attr("id"));
    $(f).closest("form").submit();
  });
});

function toggleActive(a, sibling) {
  var state = toggleIntraClass(a, "active");
  if (state==true) $(sibling).removeClass("active");
}
//TOGGLE CLASS (BINARY)
function toggleIntraClass(target, klass) {
  $(target).hasClass(klass) ? $(target).removeClass(klass) : $(target).addClass(klass);
  return $(target).hasClass(klass) ? true : false
}
function setHiddenInputs(hidden_field, id) {
  var search_id = $(hidden_field).val();
  if (search_id == id) {
    $(hidden_field).val("");
  } else if (search_id == undefined || search_id != id) {
    $(hidden_field).val(id);
  }
  return hidden_field
}
