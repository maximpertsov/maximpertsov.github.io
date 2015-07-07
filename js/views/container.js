var Container = React.createClass({
  render: function() {
    return (
      <table className="container">
        <tbody>
          <tr>
            <td>
              <Project name="Upwords"
                       gif="assets/upwords.gif"
                       href="https://github.com/maximpertsov/upwords"
                       text="Command-line version of the boardgame Upwords. It's basically
                          Scrabble except you can stack new letters on top of previously played
                          letters. Sounds fun right? Well even if it doesn't I basically learned
                          Ruby making this app, so that was fun for me. I will probably remake
                          this with the Curses library at some point to get rid of the scrolling.
                          "/>
              <Project name="Asteroid"
                       gif="assets/asteroid.gif"
                       href="https://github.com/maximpertsov/asteroid"
                       text="Basic asteroid game, with slightly more explosive weaponry, and
                          yarnballs instead on asteroids. Inspired by RiceRocks projects from
                          the Introduction to Interactive Programming in Python class on
                          Coursera. Implemented in Ruby using the Gosu 2D graphics library."/>
            </td>
          </tr>
        </tbody>
      </table>
    );
  }
});

var Project = React.createClass({
  render: function() {
    return (
      <a href={this.props.href}>
        <table className="project">
          <tbody>
            <tr>
              <td>
                <center>
                  <h2>{this.props.name}</h2>
                </center>
              </td>
            </tr>
            <tr>
              <td>
                <center>
                  <img src={this.props.gif} style={{width:'85%'}}/>
                </center>
              </td>
            </tr>
            <tr>
              <td>
                <p>{this.props.text}</p>
              </td>
            </tr>
          </tbody>
        </table>
      </a>
    );
  }
});
