/* global riot */
riot.tag('dropdown', '  <a name="toggle" href="#" onclick="{ toggle }"> { opts.button } </a>  <div name="dropdown" class="{ open: this.out }"> <yield></yield> </div>', 'dropdown , [riot-tag="dropdown"] { position: relative; } dropdown div , [riot-tag="dropdown"] div { display: none; background: white; padding: 8px; box-shadow: 0px 0px 5px 1px rgba(0,0,0,0.3); position: absolute; top: 100%; left: 0; z-index: 100; margin-top: 5px; } dropdown div.open , [riot-tag="dropdown"] div.open { display: block; }', function(opts) {
    this.toggle = function(e){
      e.stopImmediatePropagation();
      var self = this;
      this.out = !self.out;

      function handler(e){
        var elem = e.target;
        var found = false;
        while(elem){
          if(elem === self.dropdown){
            found = true;
            break;
          }
          elem = elem.parent;
        }
        if(!found){
          e.stopImmediatePropagation();
          document.body.removeEventListener('click', handler, false);
          self.toggle(e);
        }
      }

      if(this.out){
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

    };

});
