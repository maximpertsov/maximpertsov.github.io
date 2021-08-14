import { Elm } from "./Main.elm";

// Mobile view

const MediaQuery = Object.freeze({
  NARROW: "(max-width: 900px)",
  WIDE: "(min-width: 900px)",
});

const mediaQuery = window.matchMedia(MediaQuery.WIDE);

// Setup app

const app = Elm.Main.init({
  node: document.getElementById("main"),
  flags: {
    mobileView: !mediaQuery.matches,
  },
});

// Handle Media Query updates

mediaQuery.addListener((event) => {
  app.ports.mobileViewReceiver.send(!event.matches);
});
