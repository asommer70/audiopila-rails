var HelloMessage = React.createClass({
  render: function() {
    return <div className="greeting">
      <h2>Hello Balls...</h2>
      <p>{this.props.name}</p>
    </div>
  }
})
