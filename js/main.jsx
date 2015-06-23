var Blog = React.createClass({
  render: function() {
    return (
      <div className="blog">
	<NavBar links={this.props.navlinks} />
	<Container projects={this.props.projects}/>
	<Footer />
      </div>
    );
  }
});

var NavBar = React.createClass({
  render: function() {
    var links = this.props.links.map(function(link) {
      return (
	<li>
	  <a href={link.href}>{link.text}</a>
	</li>
      );
    });  
    return (
      <div className="navBar">
	<nav> 
	  <ul>
	    {links}
	  </ul> 
	</nav>
      </div>
    );
  }
});

var NAVLINKS = [
  {href: './index.html', text: 'Home'}
  /* ,
     {href: '/about', text: 'About'},
     {href: '/cv', text: 'CV'},
     {href: '/blog', text: 'Blog'} */
];

var Container = React.createClass({
  render: function() {
    // Greet in different lanuages
    var greeting = function() {
      var greetings = ['Hello', 'Hola', 'Привет', 'こんにちは'];
      var minutes = (new Date()).getMinutes();
      return greetings[minutes % greetings.length] + "!"
    };
    return (
      <div className="container">
	<h1>{greeting()}</h1>
	<p>
	  This website does not have a purpose but I will give it one soon. In the meantime,
      why not check out my <a href="https://github.com/maximpertsov">github repository</a>?
	</p>
	<ProjectList projects={this.props.projects} />
      </div>
    );
  }
});

var ProjectList = React.createClass({
  render: function() {
    var projects = this.props.projects.map(function(project) {
      return (
	<li>
	  <a href={project.href}>{project.text}</a>
	</li>
      );
    });
    return (
      <div className="projectList">
	<h2>Projects</h2>
	<div id="projects">
	  <ul>
	    {projects}
	  </ul>
	</div>
      </div>
    );
  }
});

var PROJECTS = [
  {href: 'https://github.com/maximpertsov/upwords', text: 'Upwords'},
  {href: 'https://github.com/maximpertsov/asteroid', text: 'Asteroid'},
  {href: 'https://github.com/maximpertsov/yarnballs', text: 'Yarnballs'},
  {href: 'https://github.com/maximpertsov/durak', text: 'Durak'}
];

var Footer = React.createClass({
  render: function() {
    return (
      <div className="footer">
	<footer>
	  <ul>
	    <li><a href="https://github.com/maximpertsov">github.com/maximpertsov</a></li>
	  </ul>
	</footer>
      </div>
    );
  }
});

React.render(<Blog navlinks={NAVLINKS} projects={PROJECTS}/>, document.getElementById('content'));
