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
    :scope > div {
      display: none;
      background: white;
      box-shadow: 0px 0px 5px 1px rgba(0,0,0,0.3);
      position: absolute;
      top: 100%;
      left: 0;
      z-index: 100;
      margin-top: 5px;
    }

    :scope > div.open {
      display: block;
    }
  </style>

  <script>

    //this.mixin('getSetOpts');

    var self = this;

    self.on('mount', function(){
      self.togglebutton.innerHTML = opts.button;
      self.out = false;
    });

    function handler(e){
      if(!self.root.contains(e.target) || e.keyCode === 27){
        document.body.removeEventListener('click', handler, false);
        document.body.removeEventListener('keydown', handler, false);
        self.out = false;
        self.update();
      }
    }

    toggle(e){
      self.out = !self.out;

      if(self.out){
        var rect = self.dropdown.getBoundingClientRect();
        var leftOffset = window.innerWidth - rect.left;
        var rightOffset = window.innerWidth - rect.right;
        if(leftOffset < 0){
          self.dropdown.style.left -= leftOffset;
        } else if(rightOffset < 0){
          self.dropdown.style.right -= rightOffset;
        }
        document.body.addEventListener('click', handler, false);
        document.body.addEventListener('keydown', handler, false);
      } else {
        document.body.removeEventListener('click', handler, false);
        document.body.removeEventListener('keydown', handler, false);
      }
    }
  </script>

</dropdown>
