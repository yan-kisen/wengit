<!-- an input to filter whatever -->
<filter>

  <input name="filter" type="text" placeholder={ opts.placeholder } onkeyup={ key }>
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
      line-height: initial;
    }
  </style>

  <script>
    // default state
    this.empty = true;

    this.root.riot = this;

    // make the element observable
    riot.observable(this.root);

    clear(e){
      // when the clear button is pressed
      // clear the input
      this.filter.value = "";
      // set the state
      this.empty = true;
      // focus it for new input
      this.filter.focus();
      // trigger the change event on the element
      this.root.trigger('change', e, '')
    }

    key(e){
      // if the input isn't empty
      this.empty = !this.filter.value.trim().length;
      // trigger a change event
      this.root.trigger('change', e, this.filter.value);
      return true;
    }
  </script>
</filter>

<!-- a select element like select2, but no jQuery -->
<three-sel>

  <a name="toggle" href="#" onclick={ toggle }>
    <span name="selection">{ selectedText }</span><i class="fa fa-caret-down"></i>
  </a>

  <ul name="dropdown" class={ open: this.out } onclick={ optionClicked }>
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

    > ul {
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
      overflow-y: auto;
    }

    > ul.open {
      display: block;
    }

    > ul,
    > ul > li,
    > ul > lh {
      list-style: none;
    }

    > ul > li > a {
      display: block;
      height: 30px;
      line-height: 30px;
      border-top: 1px solid lightgrey;
      margin: 0 -8px;
      padding: 0 8px;
    }

    > ul > li > a:focus,
    > ul > li > a.focus,
    > ul > li > a:hover,
    > ul > li > a.hover {
      border: 1px dashed lightgrey;
      padding: 0 7px;
    }

  </style>

  <script>

    // store this in a different variable
    var self = this;
    // default state
    self.out = false;
    self.on('mount update', function(){
      // set text to the selected option text
      self.selectedText = self.selected && self.selected.textContent + " ";
      // set value to the selected option's value
      self.root.value = self.selected && (self.selected.dataset.value || self.selectText);
    });

    self.on('mount', function(){
      // when the filter is typed in
      self.filter.on('change', filterChanged);
      // set default text and value
      self.selected = self.dropdown.querySelector('li.selected') || self.dropdown.childNodes[1];
    });

    function filterChanged(e, val){
      // get list of elements
      var elems = self.dropdown.querySelectorAll('li[data-value]'), l = elems.length;
      // clean up text
      val = val.trim().toLowerCase();
      // if anything is entered
      if(val.length){
        // loop through elements
        for(var i = 0; i < l; i++){
          // if the element's value fuzzy matches what was entered
          if(fuzzy(val, elems[i].dataset.value.toLowerCase())){
            // show it
            elems[i].style.display = 'block';
          } else {
            // hide it
            elems[i].style.display = 'none';
          }
        }
      } else {
        // show all elements
        for(var i = 0; i < l; i++){
          elems[i].style.display = 'block';
        }
      }
    }

    optionClicked(e){
      // if the click really occurred within the dropdown
      if(self.dropdown.contains(e.target)){
        // loop up through parents to the nearest LI node
        var el = e.target;
        while(el && el.tagName.toLowerCase() !== "ul"){
          if(el.tagName.toLowerCase() === 'li'){
            // once LI is found
            // set is as the selected node
            self.selected = el;
            // remove event listeners
            document.body.removeEventListener('click', handler, false);
            document.body.removeEventListener('keydown', handler, false);
            // set the dropdown closed
            self.out = false;
            // clear the filter
            self.filter.riot.clear();
            self.filter.riot.update();
            break;
          }
          el = el.parentNode;
        }
      }
    }

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
        // check if it overflows the page, and move it in if it does
        var rect = self.dropdown.getBoundingClientRect();
        var leftOffset = window.innerWidth - rect.left;
        var rightOffset = window.innerWidth - rect.right;
        if(leftOffset < 0){
          self.dropdown.style.left -= leftOffset;
        } else if(rightOffset < 0){
          self.dropdown.style.right -= rightOffset;
        }
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
</three-sel>

<!-- Makes nice label~input groups -->
<field-group>
  <yield/>

  <style scoped>
    :scope {
      display: block;
      height: 24px;
      line-height: 24px;
    }
    > * {
      display: inline-block;
    }
    > label {
      width: 14%;
      padding-right: 10px;
      text-align: right;
    }
    > :not(label) {
      width: 85%;
      height: 100%;
    }
    input, checkbox, radio {
      height: 100%;
    }
  </style>
</field-group>

<!-- An input for selecting directories -->
<folder-input>
  <a name="open-dialog" onclick={ browse } href="#"><yield/></a>
  <input type="text" name="folder">

  <script>
    browse(){
      // show a directory browse dialog
      // store directory (if selected) in the directory variable
      var directory = Dialog.showOpenDialog({
        properties: ['openDirectory'],
        title: 'Browse for repository directory'
      });
      // if directory selected
      if(directory && directory[0]){
        directory = directory[0];
        console.log('Directory chosen', directory);
        // set it as the value of the text input
        this.folder.value = directory;
        // and as the element value
        this.root.value = directory;
      }
    }
  </script>

  <style scoped>
    input {
      display: block;
      width: calc(100% - 70px);
    }
    a {
      float: right;
    }
  </style>
</folder-input>

<!-- The check confirm box at the bottom of dropdowns and stuff -->
<confirm-action>
  <a onclick={ submit } href="#">
    <i class="fa fa-check-circle-o"></i>
    <yield/>
  </a>

  <script>
    submit(){
      // find the first form sibling
      var form = this.root.parentNode.querySelector('form');
      // trigger the SUBMIT event on it
      // different from actually submitting,
      // as this can be intercepted or cancelled
      form.dispatchEvent(new Event("submit"));
    }
  </script>

  <style>
    confirm-action {
      display: block;
    }
    confirm-action a {
      display: block;
      border-top: 1px solid lightgrey;
      font-size: 14px;
      text-align: center;
      padding: 20px;
    }
    confirm-action i.fa {
      font-size: 28px;
      position: relative;
      line-height: 0px;
      bottom: -4px;
      margin-right: 2px;
    }
    confirm-action[disabled] a {
      background-color: whitesmoke;
      color: lightgrey;
      cursor: default;
      pointer-events: none;
      -webkit-user-select: none;
    }
  </style>
</confirm-action>
