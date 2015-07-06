var App = React.createClass({
  render: function() {
    return (
      <div className="app">
        <NavBar />
        <AboutMe />
        <Container />
      </div>
    );
  }
});

React.render(<App />, document.getElementById('content'));
