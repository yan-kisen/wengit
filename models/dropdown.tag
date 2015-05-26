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
    div {
      display: none;
      background: white;
      padding: 8px;
      box-shadow: 0px 0px 5px 1px rgba(0,0,0,0.3);
      position: absolute;
      top: 100%;
      left: 0;
      z-index: 100;
      margin-top: 5px;
    }

    div.open {
      display: block;
    }
  </style>

  <script>

    this.mixin('getSetOpts');

    this.on('mount', function(){
      this.togglebutton.innerHTML = opts.button;
      this.out = false;
    });

    function handler(e){
      var dropdowns = self.root.querySelectorAll('*');
      if(Array.prototype.indexOf.call(dropdowns, e.target) === -1){
        document.body.removeEventListener('click', handler, false);
        self.out = false;
        self.update();
      }
    }

    var self = this;
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
      } else {
        document.body.removeEventListener('click', handler, false);
      }

    }
  </script>

</dropdown>
