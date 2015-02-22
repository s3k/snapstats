$(document).ready(function () {
  ({

    when_cat : "li.section-user",

    init : function () {
      var self = this;
      
      if ( $(self.when_cat).length <= 0 ){
        return false;
      }

      // do stuff
    }

  }).init();
});
