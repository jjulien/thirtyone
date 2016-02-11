window.App = window.App || {};

App.init = function() {
  // any javascript that needs to be initialized on every page should go here
  $(document).foundation();
};

$(document).ready(function() {
  App.init();
});
