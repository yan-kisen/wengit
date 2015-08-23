<repo-list>
  <filter placeholder="Filter repositories"><i class="fa fa-remove"></i></filter>
  <ul name="list">
    <!-- repo headers (from different sources like GitHub or Bitbucket) -->
    <!-- are added as LH elements -->

    <!-- repositories are added as LI elements -->

    <!-- account headers can be added as I tags -->

  </ul>
  <script>
    var self = this;

    self.on("mount update", function(){
      for(var repo of data.repositories){
        var a = document.createElement('a');
        a.href = "#";
        var li = document.createElement('li');
        Object.assign(li.dataset, repo);
        a.innerHTML = repo.name;
        li.appendChild(a);
        self.list.appendChild(li);
      }
    });

    self.list.on("click", function(e){
      var elem = e.target.closest("li");
      if(elem){
        wengit.showRepository(elem.dataset.repoID);
        elem.parentNode.querySelector("li.active").classList.remove("active");
        elem.classList.add("active");
      }
    });
  </script>
</repo-list>
