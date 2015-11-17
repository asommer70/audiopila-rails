ready_albums = ->

  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'


  #
  # Handle Album playback controls.
  #
  $('.control').on 'click', (e) ->
    $this = $(this)
    if $this.hasClass('change')
      media_control.change_audio($this.data().album, parseInt($this.data().function))
    else
      console.log('this.data().function:', $this.data().function)
      media_control[$this.data().function]($this.data().album)
      console.log('after this.data().function:', $this.data().function)

@media_control = {
  play: (id) ->
    $('#play').toggleClass('warning')
    if !$('#pause').hasClass('warning')
      $('#pause').toggleClass('warning')

    $.get("/albums/#{id}.json")
      .then (album) ->
        if album.current_audio != null
          if !media_control.current_audio?
            media_control.current_audio = media_control.find_current_aduio(album)
        else
          media_control.current_audio = {
            album: album,
            audio: album.audios[0],
            current_player: $('#' + album.audios[0].id)[0],
          }

        media_control.current_audio.current_player.play()
        media_control.update_album(album, media_control.current_audio)


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

  change_audio: (id, direction) ->
    # $.get("/albums/#{id}.json")
    #   .then (album) ->
        if !media_control.current_audio?
          media_control.play(id)
          # media_control.pause(id)
          # media_control.change_audio(id, direction)
        else if media_control.current_audio?
          media_control.current_audio.current_player.pause()

          # Find the index of the next/previous Audio
          audios = media_control.current_audio.album.audios
          for audio, idx in audios
            if media_control.current_audio.audio.id == audio.id
              current = idx + direction
              console.log('current:', current)
              if current == audios.length
                current = 0
              else if current == -1
                current = media_control.current_audio.album.audios.length - 1
              media_control.current_audio = {
                album: media_control.current_audio.album
                audio: audios[current],
                current_player: $('#' + audios[current].id)[0],
              }
              break
        else if media_control.current_audio.album.current_audio?
          # Album isn't playing so play the last audio.
          media_control.current_audio = media_control.find_current_aduio(media_control.album)
        else

          # Album doesn't have a current_audio so start the first, or the last, audio.
          if direction == -1
            current = media_control.album.audios.length - 1
          else
            current = 0

          media_control.current_audio = {
            album: media_control.album,
            audio: media_control.album.audios[current],
            current_player: $('#' + media_control.album.audios[current].id)[0],
          }


        media_control.current_audio.current_player.play()
        media_control.update_album(media_control.current_audio.album, media_control.current_audio)

  looper: (id) ->
    console.log('setting loop...', id)
    # Give some feedback.
    $('#looper').toggleClass('warning')

    if media_control.looping?
      media_control.looping = false
    else
      media_control.looping = true

  shuffle: (id) ->
    console.log('shuffling...')
    $('#shuffle').toggleClass('warning')
    if media_control.shuffling?
      media_control.shuffling = false
    else
      media_control.shuffling = true


  find_current_aduio: (album) ->
    for audio, idx in album.audios
      if audio.id == album.current_audio
        audio = audio
        current_player = $('#' + audio.id)[0]

        return {
          album: album,
          audio: audio,
          current_player: $('#' + audio.id)[0],
        }

  update_album: (album, current_audio) ->
    $('#playing_audio').html(current_audio.audio.name + ' <em>' + current_audio.audio.album_order + '</em>')
    $.ajax({
      url: '/albums/' + album.id + '.json',
      method: 'put',
      data: 'album[current_audio]=' + current_audio.audio.id
    })
}

$(document).ready(ready_albums)
$(document).on('page:load', ready_albums)
