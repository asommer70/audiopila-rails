ready_albums = ->

  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'

$(document).ready(ready_albums)
$(document).on('page:load', ready_albums)
