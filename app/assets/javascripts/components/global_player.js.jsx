var GlobalPlayer = React.createClass({

  getInitialState: function() {
    var paths = window.location.pathname.split('/');
    var action = paths[1];
    var object_id = paths[2];

    return {
      id: localStorage.getItem('id'),
      collection: JSON.parse(localStorage.getItem('collection')),
      currentAudio: JSON.parse(localStorage.getItem('currentAudio')),
      action: localStorage.getItem('action')
    }
  },

  render: function() {
    return <div>
      <Player id={this.state.id} action={this.state.action} colleciton={this.state.collection} currentAudio={this.state.currentAudio} size='small' />
      <span className='playing_audio'><strong>Playing:</strong> {this.state.currentAudio.name}</span><br/>
      <div className="hide left">
        <Audio id={this.state.currentAudio.id} audio={this.state.currentAudio} />
      </div>
    </div>
  }
});
