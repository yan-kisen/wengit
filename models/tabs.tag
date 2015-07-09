<!-- a tabbed switcher between content -->
<tabs>
  <div name="container" onclick={ click }>
    <yield/>
  </div>

  <style scoped>
    :scope {
      display: block;
    }

    > div {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
    }

    > div > tab-button {
      width: auto;
      flex: 1 1 auto;
      align-self: flex-start;
      order: 1;
      text-align: center;
      padding: 18px 0;
      border-bottom: 1px solid lightgrey;
      font-size: 14px;
    }

    > div > tab-button.active > a {
      border-bottom: 2px solid royalblue;
    }

    > div > tab-button > a {
      font-weight: bold;
    }

    > div > tab {
      width: 100%;
      flex: main-size;
      align-self: flex-end;
      order: 5;
      display: none;
    }

    > div > tab.active {
      display: block;
    }
  </style>

  <script>
    click(e){
      // the clicked tab-button
      var elem = e.target.closest('tab-button');

      // if it's a tab button
      if(elem){
        // everything with the active class
        for(var it of this.container.querySelectorAll(":scope > .active")){
          // remove the active class
          it.classList.remove("active");
        }
        // find the index of the tab-button
        var k = 1, el = elem;
        while(!el.matches("tab-button:nth-of-type("+k+")")) { ++k; }
        // add the active class to the tab
        elem.classList.add("active");
        // show the tab with the same index
        this.container.querySelector(":scope > tab:nth-of-type("+k+")").classList.add("active");
      }

    }
  </script>
</tabs>

<!-- each button for each tab defined by one of these -->
<tab-button>
  <a href="#">
    <yield/>
  </a>
</tab-button>

<!-- each tab within the switcher defined by one of these -->
<tab>
  <yield/>
</tab>
