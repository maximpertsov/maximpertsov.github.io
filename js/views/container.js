var Container = React.createClass({
  render: function() {
    return (
      <table className="container">
        <tbody>
          <tr>
            <td>
              <Project
                name="Asteroid"
                gif="assets/asteroid.gif"
                href="https://github.com/maximpertsov/asteroid"/>
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
                  <img src={this.props.gif} style={{width:'80%'}}/>
                </center>
              </td>
            </tr>
            <tr>
              <td>
                <p>
                  Basic asteroid game. Inspired by RiceRocks projects from
                  the 'Introduction to Interactive Programming in Python' class on Coursera.
                  Implemented in Ruby using the Gosu 2D graphics library. Artwork by
                  Kim Lapthrop and Rob <a
                  href="http://robsonbillponte666.deviantart.com">robsonbillponte666</a>.
                </p>
              </td>
            </tr>
          </tbody>
        </table>
      </a>
    );
  }
});
