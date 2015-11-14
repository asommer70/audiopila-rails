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
      media_control[$this.data().function]($this.data().album)

@media_control = {
  play: (id) ->
    $.get("/albums/#{id}.json")
      .then (album) ->
        if album.current_audio != null
          if !media_control.current_audio?
            media_control.current_audio = media_control.find_current_aduio(album)
        else
          media_control.current_audio = {
            audio: album.audios[0],
            current_player: $('#' + album.audios[0].id)[0],
          }

        media_control.current_audio.current_player.play()
        media_control.update_album(album, media_control.current_audio)


  pause: (id) ->
    if media_control.current_audio?
      media_control.current_audio.current_player.pause()

  change_audio: (id, direction) ->
    $.get("/albums/#{id}.json")
      .then (album) ->
        if media_control.current_audio?
          media_control.current_audio.current_player.pause()


          # Find the index of the next/previous Audio
          for audio, idx in album.audios
            if media_control.current_audio.audio.id == audio.id
              current = idx + direction
              if current == album.audios.length
                current = 0
              else if current == -1
                current = album.audios.length - 1
              media_control.current_audio = {
                audio: album.audios[current],
                current_player: $('#' + album.audios[current].id)[0],
              }
              break
        else if album.current_audio?
          # Album isn't playing so play the last audio.
          media_control.current_audio = media_control.find_current_aduio(album)
        else
          # Album doesn't have a current_audio so start the first, or the last, audio.
          if direction == -1
            current = album.audios.length - 1
          else
            current = 0

          media_control.current_audio = {
            audio: album.audios[current],
            current_player: $('#' + album.audios[current].id)[0],
          }


        media_control.current_audio.current_player.play()
        media_control.update_album(album, media_control.current_audio)

  find_current_aduio: (album) ->
    for audio, idx in album.audios
      if audio.id == album.current_audio
        audio = audio
        current_player = $('#' + audio.id)[0]

        if idx + 1 == album.audios.length
          next = 0
          previous = album.audios.length - 1
        else
          next = idx + 1
          previous = idx

        return {
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
