ready_audio = ->
  #
  # Handle Player actions.
  #
  if $('.player').length > 0
    #
    # Disable spacebar paging.
    #
    # if $('audio').length != 0
    #   $(window).on 'keydown', (e) ->
    #     return !(e.keyCode == 32);

    $('.player')

    # Save playback_time when paused.
    # #$('.player').on 'pause', (e) ->
    #   $player = $(this)
    #
    #   # Do some Maths on the playback time.
    #   playbackTime = getPlaybackTime(this.currentTime)
    #
    #   # Do the putting.
    #   $.ajax({
    #     url: '/audios/' + $player.data().audio  + '.json',
    #     method: 'put',
    #     data: 'audio[playback_time]=' + playbackTime
    #   })

    # Start playing at the playback_time.
    # .on 'play', (e) ->
    #   e.preventDefault()
    #   e.stopPropagation()
    #   play_location(this)


    # # Play and pause on space bar.
    # .on 'keyup', (e) ->
    #   this.focus()
    #   e.preventDefault()
    #   e.stopPropagation()
    #   player = $('.player')[0]
    #
    #   if (e.keyCode == 32 && player.paused == true)
    #     player.play()
    #   else if (e.keyCode == 32 && player.paused == false)
    #     player.pause()
    #
    # # Scroll playback time forward and backward with the Arrow keys.
    # .on 'keydown', (e) ->
    #   player = $('.player')[0]
    #
    #   if (e.keyCode == 39)
    #     player.currentTime += 1
    #   else if (e.keyCode == 37)
    #     player.currentTime -= 1
    #
    # # Seek the audio on scroll.
    # .on 'wheel', (e) ->
    #   e.preventDefault()
    #   e.stopPropagation()
    #   player = $(this)[0]
    #   $player = $(player)
    #   $player.focus()
    #
    #   if e.originalEvent.wheelDelta > 0
    #     player.currentTime += 1
    #   else
    #     player.currentTime -= 1

    # .on 'ended', (e) ->
    #   $player = $(this)

      # $.ajax({
      #   url: '/audios/' + $player.data().audio  + '.json',
      #   method: 'put',
      #   data: 'audio[playback_time]=' + 0
      # })

      # if media_control.current_audio?
      #   if media_control.current_audio.audio.id == $player.data().audio
      #     # If shuffling is on play a random audio.
      #     if media_control.shuffling
      #       random = Math.round(Math.random() * media_control.current_audio.album.audios.length)
      #
      #       # Don't let the current audio play back to back.
      #       if random == media_control.current_player.audio.album_order
      #         random = Math.round(Math.random() * media_control.current_audio.album.audios.length)
      #
      #       media_control.current_audio = {
      #         album: media_control.current_audio.album,
      #         audio: media_control.current_audio.album.audios[random],
      #         current_player: $('#' + media_control.current_audio.album.audios[random].id)[0],
      #       }
      #       media_control.play(media_control.current_audio.album.id)
      #     else
      #       # If the audio is the last one and looping is on then start the first one.
      #       if media_control.current_audio.audio.album_order == media_control.current_audio.album.audios.length
      #         if media_control.looping
      #           media_control.change_audio(media_control.current_audio.album.id, 1)
      #         else
      #           return
      #       else
      #         media_control.change_audio(media_control.current_audio.album.id, 1)



getPlaybackTime = (time) ->
  hours = Math.floor(time / 3600)
  minutes = Math.floor(time / 60)
  if (minutes > 59)
    minutes = Math.floor(time / 60) - 60

  seconds = Math.round(time - minutes * 60)
  if (seconds > 3599)
    seconds = Math.round(time - minutes * 60) - 3600

  return time


play_location = (audio) ->
  self = audio
  $player = $(audio)

  playbackTime = getPlaybackTime(audio.currentTime)

  $.get('/audios/' + $player.data().audio + '.json').then (data) ->
    self.currentTime = data.playback_time;
    self.play()


# Fire the ready function on load and refresh.
$(document).ready(ready_audio)
$(document).on('page:load', ready_audio)
