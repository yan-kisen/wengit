<tabs>
<!-- a tabbed switcher between content -->
  <div name="container" onclick={ click }>
    <yield/>
  </div>

  <style scoped>
    :scope {
      display: block;
    }

    :scope > div {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
    }

    :scope > div > tab-button {
      width: auto;
      flex: 1 1 auto;
      align-self: flex-start;
      order: 1;
      text-align: center;
      padding: 18px 0;
      border-bottom: 1px solid lightgrey;
    }

    :scope > div > tab-button.active a {
      text-decoration: underline;
    }

    :scope > div > tab {
      width: 100%;
      flex: main-size;
      align-self: flex-end;
      order: 5;
      display: none;
    }

    :scope > div > tab.active {
      display: block;
    }
  </style>

  <script>
    click(e){
      var elem = e.target;

      if(elem.matches("tab-button, tab-button *")){

        Array.prototype.forEach.call(this.container.querySelectorAll(":scope > .active"), function(it){
          it.className = it.className.replace("active", "");
        });

        while(elem.tagName.toLowerCase() !== "tab-button"){
          elem = elem.parentNode;
        }

        var k = 1, el = elem;
        while(!el.matches(":nth-of-type("+k+")")) { ++k; }

        elem.className += "active";

        this.container.querySelector(":scope > tab:nth-of-type("+k+")").className += "active";
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
