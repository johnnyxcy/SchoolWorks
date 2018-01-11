(function() {

      window.onload = function() {
        let click = document.getElementById("encrypt");
        click.onclick = pop;
      };

      function pop() {
          alter("Hello world!");
      }
})();