# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $("#user_postcode").jpostal({
    postcode : [ "#postcode" ],
    address  : {
                  "#prefecture_code" : "%3",
                  "#city"            : "%4",
                  "#street"          : "%5%6%7"
                }
  });