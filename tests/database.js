var database = require(../database);

var testData = {
  // something like database.defaultData
};

function equals(obj1, obj2){
  for(let key of Object.keys(obj1)){
    if(!obj2[key]){
      return false;
    }
    if(typeof obj1[key] === "object"){
      if(!equals(obj1[key], obj2[key])){
        return false;
      }
      break;
    }
    if(obj1[key] != obj2[key]){
      return false;
    }
  }
}

module.exports = function(callback){

  var obj1 = {
    a: 2,
    b: "c",
    c: {
      hello: "world",
      goodbye: [
        'h',
        'j',
        3,
        8
      ]
    }
  };

  var obj2 = {
    no: "true"
  };

  if( equals(obj1, obj2) || !equals( obj1, JSON.parse(JSON.stringify(obj1)) ) ){
    return callback(false);
  }

  database.save(testData, function(){
    var data = database.load();
    callback(data && equals(data, testData));
    database.purge();
  });
};
