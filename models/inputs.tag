<filter>
<!-- an input to filter certain things -->

  <input name="filter" type="text"
    placeholder={ opts.placeholder } onkeydown={ this.keydown }>
  <span onclick={ this.clear } hide={ this.empty }>
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
    span {
      position: absolute;
      right: 0;
      padding: 3px;
      top: 0;
    }
  </style>

  <script>
    this.empty = true;
    riot.observable(this);

    clear(e){
      this.filter.value = "";
      this.empty = true;
      this.filter.focus();
    }
    keydown(e){
      if(this.filter.value.trim().length){
        this.empty = false;
      } else {
        this.empty = true;
      }
      this.trigger('change', this.filter.value);
      return true;
    }
  </script>

</filter>

<select3>
<!-- a select element like select2 -->

  <a name="toggle" href="#" onclick={ toggle }>
    <span name="selection">{ selected.innerHTML }</span><i class="fa fa-caret-down"></i>
  </a>

  <ul name="dropdown" class={ open: this.out }>
    <lh>
      <filter name="filter" placeholder="Filter options">
        <i class="fa fa-times"></i>
      </filter>
    </lh>
    <!-- passed list elements become the list -->
    <yield/>
  </ul>

  <style scoped>
    :scope {
      display: inline-block;
      position: relative;
    }
    :scope > ul {
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
    :scope > ul.open {
      display: block;
    }
    :scope > ul,
    :scope > ul > li,
    :scope > ul > lh {
      list-style: none;
    }
  </style>

  <script>
    var self = this;
    self.on('mount', function(){
      self.selected = self.dropdown.querySelectorAll('li.selected');
      self.out = false;
    });

    function handler(e){
      if(e.target.matches("select3 > "))
      if(!e.target.matches("dropdown *") || e.keyCode === 27){
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

    self.filter.on('change', function(val){
      val = val.trim();
      if(val.length){
        for(var elems = self.dropdown.querySelectorAll('li[data-value]'), l = elems.length, i = 1; i < l; i++){
          if(fuzzy(val, elems[i].innerHTML)){
            elems[i].style.display = 'block';
          } else {
            elems[i].style.display = 'none';
          }
        }
      }
    });

  </script>
</select3>
