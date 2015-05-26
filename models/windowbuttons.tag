<windowbuttons>
<!-- custom window buttons for minimize, maximize, close -->

  <!-- right corner -->
  <span>
    <!-- minimize button -->
    <a href="#" id="minimize" onclick={ minimize } title="minimize"><i>_</i></a>
    <!-- maximize button -->
    <a href="#" id="maximize" onclick={ maximize } title="maximize" class={ max: maximized }>
      <i class="fa fa-square-o"></i>
      <i if={ maximized } class="fa fa-square-o"></i>
    </a>
    <!-- close button -->
    <a href="#" id="close" onclick={ close } title="close"><i class="fa fa-remove"></i></a>
  </span>
  <div></div>

  <style scoped>
    /* makes everything easier */
    * {
      box-sizing: border-box;
    }
    /* remove focus style for webkit */
    :focus {
      outline: none;
    }

    :scope {
      display: block;
      /* the bar acts as the window titlebar, so is draggable*/
      -webkit-app-region: drag;
    }
    div {
      clear: both;
    }
    span {
      /* exclude buttons from dragging */
      -webkit-app-region: no-drag;
      display: block;

      /* the buttons float right */
      float: right;
      height: 28px;
      overflow: hidden;
    }

    /* button default display */
    span a {
      position: relative;
      padding: 5px 4px;
      color: lightgrey;
      display: inline-block;
      text-decoration: none;
      height: 100%;
    }
    span > a > i {
      min-width: 21px;
      max-width: 21px;
      display: inline-block;
      text-align: center;
    }
    span a#minimize i {
      position: relative;
      top: -3px;
    }
    span > a#maximize > i {
      font-size: 83%;
    }

    /* button hover style */
    span a:hover {
      background-color: lightgrey;
      color: black;
    }
    span a#close:hover {
      /* close button hovers white on red */
      background-color: red;
      color: white;
    }

    /* button active style */
    span a:active {
      background: lightblue;
      color: black;
    }
    span a#close:active {
      /* close button clicks white on dark red */
      background-color: darkred;
      color: white;
    }

    /* maximize button style when maximized */
    span > a#maximize > i:nth-child(2) {
      position: absolute;
      top: 5px;
      left: 6px;
    }
    span a#maximize.max {
      width: 30px;
    }

    /* there's this stupid space between them for some reason */
    span a:nth-last-child(n+2) {
      margin-right: -4px;
    }
  </style>

  <script>

    this.on('update', function(){
      this.maximized = mainWindow().isMaximized();
    });

    // minimize window when minimize button clicked
    minimize(e){
      e.preventDefault();
      mainWindow().minimize();
    }
    // toggle window maximization on maximize click
    maximize(e){
      e.preventDefault();
      if(mainWindow().isMaximized()){
        mainWindow().unmaximize();
      } else {
        mainWindow().maximize();
      }
    }
    // close window when close button is clicked
    close(e){
      e.preventDefault();
      mainWindow().close();
    }
  </script>

</windowbuttons>
