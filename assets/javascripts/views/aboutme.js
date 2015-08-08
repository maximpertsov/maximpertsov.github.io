var AboutMe = React.createClass({
  render: function() {
    return (
      <div className="aboutMe">
        <Greeting />
        <Blurb />
      </div>
    );
  }
});

var Greeting = React.createClass({
  render: function() {
    var sayHello = function() {
      var greetings = ['Hello', '¡Hola', 'Привет', 'こんにちは'];
      var minutes = (new Date()).getMinutes();
      return greetings[minutes % greetings.length] + "!";
    };
    return (
      <div className="greeting">
        <h1>{sayHello()}</h1>
      </div>
    );
  }
});

var Blurb = React.createClass({
  render: function() {
    return (
      <div className="blurb">
        <p>
          Welcome to my Github site. Check out some of my projects below.
        </p>
      </div>
    );
  }
});
