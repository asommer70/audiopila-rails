var Player = React.createClass({

  getInitialState: function() {
    return {
      buttonColor: 'warning',
      playing: false,
      status: 'fi-play',
      currentAudio: this.props.currentAudio,
      collection: this.props.audios,
      looper: false,
      shuffle: false
    }
  },

  componentDidMount: function() {
    /**
     * Handle shuffle and looping when audio ends.
    */
    $(document).on('playback-ended', () => {
      if (this.state.shuffle) {
          var random = this.getRandomPos();
          var currentPlayer = $('#' + this.state.collection[random].id)[0];

          this.setState({currentAudio: this.state.collection[random], currentPlayer: currentPlayer, playing: true}, () => {
            //this.play();
            this.state.currentPlayer.play();
            this.updateCollection();
          });
      } else {
        // If the audio is the last one and looping is on then start the first one.
        if (this.state.currentAudio.album_order == this.state.collection.length) {
          if (this.state.looper) {
            this.changeAudio(1);
          } else {
            // If it is the last audio and album/playlist is not set to loop just return and stop playback.
            return;
          }
        } else {
          // If not last audio advance to next.
          this.changeAudio(1);
        }
      }
    });
  },

  findCurrentAudio: function() {
    var current = undefined;

    for (i in this.state.collection) {
      if (this.state.collection[i].id == this.state.currentAudio.id) {
        current = parseInt(i);
      }
    }
    return current;
  },

  getRandomPos: function() {
    var random = Math.floor(Math.random() * this.state.collection.length);

    // Don't let the current audio play back to back.
    var current = this.findCurrentAudio();
    while (random == current) {
      random = Math.floor(Math.random() * this.state.collection.length)
    }
    return random;
  },

  updateCollection: function() {
    if (this.props.action == 'albums') {
      $('#playing_audio').html(this.state.currentAudio.name)
      field = 'album[current_audio]='
    } else {
      $('#playing_audio').html(this.state.currentAudio.name)
      field = 'playlist[current_audio]='
    }

    $.ajax({
      url: '/' + this.props.action + '/' + this.props.id + '.json',
      method: 'put',
      data: field + this.state.currentAudio.id
    })
  },

  play: function() {
    if (this.state.playing) {
      this.setState({buttonColor: 'warning', status: 'fi-pause', playing: false});
      this.pause();
    } else {
      this.setState({buttonColor: '', status: 'fi-play'});

      if (this.state.currentPlayer === undefined) {
        if (this.state.currentAudio === null) {
          this.setState({currentAudio: this.state.collection[0], currentPlayer: $('#' + this.state.collection[0].id)[0]}, () => {
            $('#' + this.state.currentAudio.id)[0].play()
          });
        } else {
          this.setState({ currentPlayer: $('#' + this.state.currentAudio.id)[0] });
          $('#' + this.state.currentAudio.id)[0].play()
        }
      } else {
        this.state.currentPlayer.play();
      }
      this.setState({playing: true})
    }

    this.updateCollection();
  },

  pause: function() {
    if (this.state.currentAudio !== undefined) {
      $('#pause').toggleClass('warning')
      if (!$('#play').hasClass('warning')) {
        $('#play').toggleClass('warning')
      }

      if (this.state.currentPlayer !== undefined) {
        this.state.currentPlayer.pause();
        this.setState({playing: false});
      }
    }
  },

  changeAudio: function (direction) {
    this.state.currentPlayer.pause();

    if (this.state.shuffle) {
      var random = this.getRandomPos();

      var currentAudio = this.state.collection[random]
      var currentPlayer = $('#' + this.state.collection[random].id)[0];
    } else {
      // Get next Audio and play it.
      var currentPos = this.findCurrentAudio() + direction;

      // Handle going backwards from the last Audio.
      var currentAudio = this.state.collection[currentPos];
      if (currentPos >= this.state.collection.length) {
        currentAudio = this.state.collection[0];
      } else if (currentPos == -1) {
        currentAudio = this.state.collection[this.state.collection.length - 1]
      }
      var currentPlayer = $('#' + currentAudio.id)[0];
    }

    this.setState({currentAudio: currentAudio, currentPlayer: currentPlayer}, function() {
      this.state.currentPlayer.play();
      this.updateCollection();
    });
  },

  looper: function() {
    $('#looper').toggleClass('warning')
    if (this.state.looper === true) {
      this.setState({ looper: false });
    } else {
      this.setState({ looper: true },function() {
        if (this.state.playing === false) {
          this.play();
        }
      });
    }
  },

  shuffle: function() {
    $('#shuffle').toggleClass('warning')
    if (this.state.shuffle === true) {
      this.setState({ shuffle: false });
    } else {
      this.setState({ shuffle: true },function() {
        if (this.state.playing === false) {
          this.play();
        }
      });
    }
  },

  render: function() {
    return <div className="controls">
      <button className="warning large control" onClick={this.changeAudio.bind(this, -1)}><i className="fi-previous"></i></button>&nbsp;
      <button id="play" className={"large control " + this.state.buttonColor} onClick={this.play}><i className={this.state.status}></i></button>&nbsp;
      <button className="warning large control" onClick={this.changeAudio.bind(this, 1)}><i className="fi-next"></i></button>&nbsp;
      <br/>
      <button id="looper" className="warning small control" onClick={this.looper}><i className="fi-loop"></i></button>&nbsp;
      <button id="shuffle" className="warning small control" onClick={this.shuffle}>
        <i className="fi-shuffle"></i>
      </button>
    </div>
  }
})
