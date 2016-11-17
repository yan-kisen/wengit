<window-buttons>
<!-- custom window buttons for minimize, maximize, close -->

  <!-- right corner -->
  <div class="btn-group pull-right">
      <button class="btn btn-default">
        <a href="#" id="minimize" onclick={ minimize } title="minimize">
          <i>_</i>
        </a>
      </button>
      <button class="btn btn-default">
        <a href="#" id="maximize" onclick={ maximize } title="maximize">
           <i class="fa fa-square-o"></i>
          <i class="fa fa-square-o"></i>
        </a>
      </button>
      
      <button class="btn btn-default active">
        <span class="icon icon-popup"></span>
      </button>
      <button class="btn btn-default">
         <a href="#" id="close" onclick={ close } title="close">
          <i class="fa fa-remove"></i>
         </a>
      </button>
    </div>
 

  <style>
    /* remove focus style for webkit */
    window-buttons :focus {
      outline: none;
    }

    window-buttons {
      /* the bar acts as the window titlebar, so is draggable*/
      -webkit-app-region: drag;
    }
    window-buttons div {
      /* clear: both; */
    }
    window-buttons span {
      /* exclude buttons from dragging */
      -webkit-app-region: no-drag;
      /* display: block; */

      /* the buttons float right */
      float: right;
      height: 28px;
      overflow: hidden;
    }

    /* button default display */
    window-buttons span a {
      position: relative;
      padding: 5px 4px;
      color: lightgrey;
      display: inline-block;
      text-decoration: none;
      height: 100%;
      font-size: 14px;
    }
    window-buttons span > a > i {
      min-width: 21px;
      max-width: 21px;
      display: inline-block;
      text-align: center;
    }
    window-buttons span a#minimize i {
      position: relative;
      top: -3px;
    }
    window-buttons span > a#maximize > i {
      font-size: 83%;
    }

    /* button hover style */
    window-buttons span a:hover {
      background-color: lightgrey;
      color: black;
    }
    window-buttons span a#close:hover {
      /* close button hovers white on red */
      background-color: red;
      color: white;
    }

    /* button active style */
    window-buttons span a:active {
      background: lightblue;
      color: black;
    }
    window-buttons span a#close:active {
      /* close button clicks white on dark red */
      background-color: darkred;
      color: white;
    }
    /* maximize button style when not maximized */
    window-buttons span > a#maximize > i:nth-child(2){
      display: none;
    }

    /* maximize button style when maximized */
    .max window-buttons span > a#maximize > i:nth-child(2) {
      display: initial;
      position: absolute;
      top: 5px;
      left: 6px;
    }
    
  </style>

  <script>

    // minimize window when minimize button clicked
    minimize(e){
      mainWindow.minimize();
    }
    // toggle window maximization on maximize click
    maximize(e){
      if(mainWindow.isMaximized()){
        mainWindow.unmaximize();
      } else {
        mainWindow.maximize();
      }
    }
    // close window when close button is clicked
    close(e){
      mainWindow.close();
    }
  </script>

</window-buttons>
