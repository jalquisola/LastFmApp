#= require jquery
#= require jquery_ujs
#= require chosen-jquery
#= require bootstrap-sprockets
#= require_tree .

$ ->
  $(".chosen-select").chosen
    allow_single_deselect: true,
    no_results_text: "No results matched."
    width: '200px'
  .on 'change', (ev, params) ->
    if params.selected.length == 0
      alert("Please select a country")
    else
      window.location = "/artists/#{params.selected}"
