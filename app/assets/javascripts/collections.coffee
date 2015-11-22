ready_collections = ->
  #
  # Determine the action from the pathname.
  #
  paths = window.location.pathname.split('/')
  action = paths[1]
  object_id = paths[2]

  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'


  #
  # Handle playback controls.
  #
  $('.control').on 'click', (e) ->
    $this = $(this)
    if $this.hasClass('change')
      media_control.change_audio($this.data().collection, parseInt($this.data().function), action)
    else
      media_control[$this.data().function](action, $this.data().collection)


  #
  # Handle re-ordering of Audios.
  #
  $('#audio-list').sortable({
    handle: '.handle',
    sortableClass: 'fade',
  })

  $('#audio-list').bind 'sortupdate', (e, ui) ->
    # Find the audio at the oldIndex.
    $oldIndexAudio = $($('li.audio')[ui.oldindex])

    # Determine the correct order field.
    if action == 'albums'
      field = 'audio[album_order]='
      old_url = "/audios/#{$oldIndexAudio.data().audio}.json"
      new_url = "/audios/#{ui.item.data().audio}.json"
    else
      field = 'playlist[playlist_order]='
      new_url = "/playlist_audios/#{ui.item.data().playlistAudio}"
      old_url = "/playlist_audios/#{$oldIndexAudio.data().playlistAudio}"

    # Send a PUT to each Audio to update the album_order field.
    $.ajax({
      url: old_url
      method: 'put',
      data: field + (ui.oldindex + 1)
    })

    $.ajax({
      url: new_url
      method: 'put',
      data: field + (ui.index + 1)
    })


@media_control = {
  play: (action, id) ->
    $('#play').toggleClass('warning')
    if !$('#pause').hasClass('warning')
      $('#pause').toggleClass('warning')

    $.get("/#{action}/#{id}.json")
      .then (collection) ->
        if collection.current_audio?
          if !media_control.current_audio?
            media_control.current_audio = media_control.find_current_audio(collection)
        else
          media_control.current_audio = {
            collection: collection,
            audio: collection.audios[0],
            current_player: $('#' + collection.audios[0].id)[0],
          }

        media_control.current_audio.current_player.play()
        media_control.update_collection(action, collection, media_control.current_audio)


  pause: (id) ->
    if media_control.current_audio?
      $('#pause').toggleClass('warning')
      if !$('#play').hasClass('warning')
        $('#play').toggleClass('warning')

      if media_control.current_audio.current_player.paused
        media_control.current_audio.current_player.play()
        $('#play').toggleClass('warning')
      else
        media_control.current_audio.current_player.pause()

  change_audio: (id, direction, action) ->
    if !media_control.current_audio?
      media_control.play(action, id)
    else if media_control.current_audio?
      media_control.current_audio.current_player.pause()

      # Find the index of the next/previous Audio
      audios = media_control.current_audio.collection.audios
      for audio, idx in audios
        if media_control.current_audio.audio.id == audio.id
          current = idx + direction
          if current == audios.length
            current = 0
          else if current == -1
            current = media_control.current_audio.collection.audios.length - 1
          media_control.current_audio = {
            collection: media_control.current_audio.collection
            audio: audios[current],
            current_player: $('#' + audios[current].id)[0],
          }
          break
    else if media_control.current_audio.collection.current_audio?
      # Collection isn't playing so play the last audio.
      media_control.current_audio = media_control.find_current_audio(media_control.current_audio.collection)
    else

      # Collection doesn't have a current_audio so start the first, or the last, audio.
      if direction == -1
        current = media_control.collection.audios.length - 1
      else
        current = 0

      media_control.current_audio = {
        collection: media_control.current_audio.collection,
        collection: media_control.current_audio.collection.audios[current],
        current_player: $('#' + media_control.current_audio.collection.audios[current].id)[0],
      }

    media_control.current_audio.current_player.play() if media_control.current_audio.current_player
    media_control.update_collection(action, media_control.current_audio.collection, media_control.current_audio)

  looper: (id) ->
    # Give some feedback.
    $('#looper').toggleClass('warning')

    if media_control.looping?
      media_control.looping = false
    else
      media_control.looping = true

  shuffle: (id) ->
    $('#shuffle').toggleClass('warning')
    if media_control.shuffling?
      media_control.shuffling = false
    else
      media_control.shuffling = true


  find_current_audio: (collection) ->
    for audio, idx in collection.audios
      if audio.id == collection.current_audio
        audio = audio
        current_player = $('#' + audio.id)[0]

        return {
          collection: collection,
          audio: audio,
          current_player: $('#' + audio.id)[0],
        }

  update_collection: (action, collection, current_audio) ->
    if action == 'albums'
      $('#playing_audio').html(current_audio.audio.name)
      field = 'album[current_audio]='
    else
      $('#playing_audio').html(current_audio.audio.name)
      field = 'playlist[current_audio]='

    $.ajax({
      url: "/#{action}/#{collection.id}.json",
      method: 'put',
      data: field + current_audio.audio.id
    })
}

$(document).ready(ready_collections)
$(document).on('page:load', ready_collections)
