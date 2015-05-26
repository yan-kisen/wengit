<filter>
<!-- an input to filter certain things -->

  <input name="filter" type="text" data-empty={ this.empty }
    placeholder={ opts.placeholder } onkeydown={ this.keydown }>
  <span onclick={ this.clear }>
    <!-- html passed becomes the button -->
    <yield/>
  </span>

  <style scoped>
    :scope {
      display: block;
      position: relative;
    }
    input {
      display: block;
      border: 1px solid lightgrey;
      border-radius: 2px;
      padding: 3px;
      padding-right: 30px;
      margin-bottom: 15px;
      box-sizing: border-box;
      width: 100%;
    }
    input[data-empty] ~ span {
      display: none;
    }
    span {
      position: absolute;
      right: 0;
      padding: 3px;
    }
  </style>

  <script>
    clear(e){
      this.filter.value = "";
      this.empty = true;
    }
    keydown(e){
      if(this.filter.value.trim().length){
        this.empty = false;
      } else {
        this.empty = true;
      }
      if(typeof opts.change === "function"){
        opts.change(this.filter.value);
      }
    }
  </script>

</filter>

<select3>
<!-- a select element like select2 -->

  <a name="toggle" href="#" onclick={ toggle }>
    <span name="selection">{ selected.innerHTML }</span><i class="fa fa-caret-down"></i>
  </a>

  <ul name="dropdown" class={ open: this.open }>
    <lh>
      <filter placeholder="Filter options" change={ change }>
        <i class="fa fa-times"></i>
      </filter>
    </lh>
    <!-- passed li elements become the list -->
    <yield/>
  </ul>

  <style scoped>
    :scope {
      display: inline-block;
      position: relative;
    }
    ul {
      display: none;
      background: white;
      padding: 8px;
      box-shadow: 0px 0px 5px 1px rgba(0,0,0,0.3);
      position: absolute;
      top: 100%;
      left: 0;
      z-index: 100;
      margin-top: 5px;
      max-height: 200px;
      max-width: 150px;
      overflow-y: auto;
    }
    ul.open {
      display: block;
    }
    ul,
    ul > li,
    ul > lh {
      list-style: none;
    }
  </style>

  <script>
    var self = this;
    self.on('mount', function(){
      self.selected = self.dropdown.childNodes[0];
    });
    toggle(e){
      e.stopImmediatePropagation();
      self.open = !self.open;

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

      if(self.open){
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

    change(val){
      val = val.trim();
      if(val.length){
        for(var elems = self.dropdown.childNodes, l = elems.length, i = 1; i < l; i++){
          if(fuzzy(val, elems[i].innerHTML)){
            elems[i].style.display = 'block';
          } else {
            elems[i].style.display = 'none';
          }
        }
      }
    }
  </script>
</select3>
