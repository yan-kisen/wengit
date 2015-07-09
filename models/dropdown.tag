<dropdown>
<!-- dropdown panel on button click to display stuff -->

  <!-- button to toggle drop down -->
  <a name="togglebutton" href="#" onclick={ toggle }></a>

  <!-- actual dropdown, content goes here -->
  <div name="dropdown" class={ open: this.out }>
    <yield/>
  </div>

  <style scoped>
    :scope {
      position: relative;
    }
    > div {
      display: none;
      background: white;
      box-shadow: 0px 0px 5px 1px rgba(0,0,0,0.3);
      position: absolute;
      top: 100%;
      left: 0;
      z-index: 100;
      margin-top: 5px;
    }

    > div.open {
      display: block;
    }

    > a {
      font-size: 14px;
    }
  </style>

  <script>

    // store this
    var self = this;
    // default state
    self.out = false;

    self.on('mount', function(){
      // set togglebutton stuff
      self.togglebutton.innerHTML = opts.button;
    });

    // event listener for clicking outside the dropdown
    function handler(e){
      // if click is outside the dropdown
      // or the ESC key is pressed
      if(!self.root.contains(e.target) || e.keyCode === 27){
        // set dropdown closed
        self.out = false;
        // remove event listeners
        document.body.removeEventListener('click', handler, false);
        document.body.removeEventListener('keydown', handler, false);
        // update the component
        self.update();
      }
    }

    // toggle the dropdown open / closed
    toggle(e){
      // toggle state
      self.out = !self.out;

      // if the dropdown is set out
      if(self.out){
        // // check if it overflows the page, and move it in if it does
        // var rect = self.dropdown.getBoundingClientRect();
        // var leftOffset = window.innerWidth - rect.left;
        // var rightOffset = window.innerWidth - rect.right;
        // if(leftOffset < 0){
        //   self.dropdown.style.left -= leftOffset;
        // } else if(rightOffset < 0){
        //   self.dropdown.style.right -= rightOffset;
        // }
        // add event listeners for clicking outside the dropdown
        document.body.addEventListener('click', handler, false);
        document.body.addEventListener('keydown', handler, false);
      } else {
        // remove event listeners for clicking outside the dropdown
        document.body.removeEventListener('click', handler, false);
        document.body.removeEventListener('keydown', handler, false);
      }
    }
  </script>

</dropdown>
