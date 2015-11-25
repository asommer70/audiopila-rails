var Player = React.createClass({

  getInitialState: function() {
    return {
      buttonColor: 'warning',
      playing: false,
      currentAudio: {},
      collection: {}
    }
  },

  findCurrentAudio: function() {
    for (var i=0; i < this.state.collection.audios; i++) {
      if (this.state.collection.audios[i].id == this.state.collection.currentAudio) {
        var audio = this.state.colleciotn.audios[i];
        var currentPlayer = $('#' + audio.id)[0];

        return {
          collection: collection,
          audio: audio,
          currentPlayer: $('#' + audio.id)[0],
        }
      }
    }
  },

  updateCollection: function() {
    if (this.props.action == 'albums') {
      $('#playing_audio').html(this.state.currentAudio.audio.name)
      field = 'album[current_audio]='
    } else {
      $('#playing_audio').html(this.state.currentAudio.audio.name)
      field = 'playlist[current_audio]='
    }

    $.ajax({
      url: '/' + this.props.action + '/' + this.state.collection.id + '.json',
      method: 'put',
      data: field + this.state.currentAudio.audio.id
    })
  },

  play: function() {
    console.log('playing... ' + this.props.id + ' action: ' + this.props.action);
    if (this.state.buttonColor == 'warning') {
      this.setState({buttonColor: ''});
      if (!$('#pause').hasClass('warning')) {
        $('#pause').toggleClass('warning')
      }
    } else {
      this.setState({buttonColor: 'warning'});
    }

    var self = this;

    $.get('/' + this.props.action + '/' + this.props.id + '.json')
    .then(function (collection) {
      console.log('collection:', collection);
      //this.setState({collection: collection});

      if (collection.currentAudio !== undefined) {
        if (this.state.currentAudio === undefined) {
          this.setState({currentAudio: this.findCurrentAudio()});
        }
      } else {
        self.setState({
          currentAudio: {
            audio: collection.audios[0],
            currentPlayer: $('#' + collection.audios[0].id)[0],
          },
          collection: collection
        })
      }

      console.log('media_control:', media_control);
      self.state.currentAudio.currentPlayer.play();
      self.updateCollection();
      $(document).trigger('media-play');
    })
  },

  pause: function() {
    if (this.state.currentAudio !== undefined) {
      $('#pause').toggleClass('warning')
      if (!$('#play').hasClass('warning')) {
        $('#play').toggleClass('warning')
      }
      // if (this.state.buttonColor == 'warning') {
      //   this.setState({buttonColor: ''});
      // } else {
      //   this.setState({buttonColor: 'warning'});
      // }

      if (this.state.currentAudio.currentPlayer.paused){
        this.state.currentAudio.currentPlayer.play()
        $('#play').toggleClass('warning')
      } else {
        this.state.currentAudio.currentPlayer.pause()
        $(document).trigger('media-pause')
      }
    }
  },

  render: function() {
    return <div className="controls">
      <button className="warning large control change"><i className="fi-previous"></i></button>&nbsp;
      <button id="play" className={"large control " + this.state.buttonColor} onClick={this.play}><i className="fi-play"></i></button>&nbsp;
      <button id="pause" className="warning large control" onClick={this.pause}><i className="fi-pause"></i></button>&nbsp;
      <button className="warning large control change"><i className="fi-next"></i></button>&nbsp;
      <br/>
      <button id="looper" className="warning small control"><i className="fi-loop"></i></button>&nbsp;
      <button id="shuffle" className="warning small control">
        <i className="fi-shuffle"></i>
      </button>
    </div>
  }
})
