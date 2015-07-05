var App = React.createClass({
  render: function() {
    return (
      <div className="app">
        <NavBar />
        <AboutMe />
        <Container />
        <Footer />
      </div>
    );
  }
});

var Footer = React.createClass({
  render: function() {
    return (
      <div className="footer">
        <footer>
          <ul>
            <li><a href="https://github.com/maximpertsov">github</a></li>
            <li><a href="https://www.linkedin.com/in/maximpertsov">linkedin</a></li>
          </ul>
        </footer>
      </div>
    );
  }
});

React.render(<App />, document.getElementById('content'));
