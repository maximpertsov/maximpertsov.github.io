var NavBar = React.createClass({
  getInitialState: function() {
    return {
      links: [
      	{href: 'index.html', text: 'Home'}
      ]
    };
  },
  render: function() {
    var links = this.state.links.map(function(link) {
      return (
      	<li>
      	  <a href={link.href}>{link.text}</a>
      	</li>
      );
    });
    return (
      <div className="navBar">
        <nav>
          <ul>{links}</ul>
        </nav>
      </div>
    );
  }
});
