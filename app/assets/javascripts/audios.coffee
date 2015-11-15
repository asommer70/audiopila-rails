ready_audio = ->
  #
  # Handle Player actions.
  #
  if $('.player').length > 0
    #
    # Disable spacebar paging.
    #
    if $('audio').length != 0
      $(window).on 'keydown', (e) ->
        return !(e.keyCode == 32);

    # Save playback_time when paused.
    $('.player').on 'pause', (e) ->
      $player = $(this)

      # Do some Maths on the playback time.
      playbackTime = getPlaybackTime(this.currentTime)

      # Do the putting.
      $.ajax({
        url: '/audios/' + $player.data().audio  + '.json',
        method: 'put',
        data: 'audio[playback_time]=' + playbackTime
      })

    # Start playing at the playback_time.
    .on 'play', (e) ->
      e.preventDefault()
      e.stopPropagation()
      play_location(this)

    # Play and pause on space bar.
    .on 'keyup', (e) ->
      this.focus()
      e.preventDefault()
      e.stopPropagation()
      player = $('.player')[0]

      if (e.keyCode == 32 && player.paused == true)
        player.play()
      else if (e.keyCode == 32 && player.paused == false)
        player.pause()

    # Scroll playback time forward and backward with the Arrow keys.
    .on 'keydown', (e) ->
      player = $('.player')[0]

      if (e.keyCode == 39)
        player.currentTime += 1
      else if (e.keyCode == 37)
        player.currentTime -= 1

    # Seek the audio on scroll.
    .on 'wheel', (e) ->
      e.preventDefault()
      e.stopPropagation()
      player = $(this)[0]
      $player = $(player)
      $player.focus()

      if e.originalEvent.wheelDelta > 0
        player.currentTime += 1
      else
        player.currentTime -= 1

    .on 'ended', (e) ->
      $player = $(this)
      console.log($player)

      $.ajax({
        url: '/audios/' + $player.data().audio  + '.json',
        method: 'put',
        data: 'audio[playback_time]=' + 0
      })
      # 
      # if media_control.current_audio.audio.id == $player.data().audio
      #   media_control.current_audio = {
      #     audio: album.audios[0],
      #     current_player: $('#' + album.audios[0].id)[0],
      #   }



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
