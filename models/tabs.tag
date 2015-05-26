<tabs onclick={ click }>
<!-- a tabbed switcher between content -->

  <yield/>

  <style scoped>
    :scope {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
    }

    tab-button {
      width: auto;
      flex: 1 1 auto;
      align-self: flex-start;
      order: 1;
      text-align: center;
    }
    tab {
      width: 100%;
      flex: main-size;
      align-self: flex-end;
      order: 5;
    }
  </style>

  <script>
    click (e){
      var el = e.target;

      while(el){
        if(el.tagName === "tabs" || el.tagName === "tab"){
          break;
        }
        if(el.tagName === "tab-button"){
          var k = 0, e = elem;
          while (e = e.previousSibling) { ++k;}

          Array.prototype.forEach.call(this.childNodes, function(elem){
            elem.className = elem.className.replace("active", "");
          });
          e.className += "active";

          this.querySelectorAll(":scope > tab")[k].className = "active";

          break;
        }
        el = el.parentNode;
      }
    }
  </script>
</tabs>

<!-- each button for each tab defined by one of these -->
<tab-button>
  <yield/>
</tab-button>

<!-- each tab within the switcher defined by one of these -->
<tab>
  <yield/>
</tab>
