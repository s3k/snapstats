$(document).ready(function () {
  ({

    when_cat : "li.section-user",
    data_path : "/snap/user/activity/2/chart",

    init : function () {
      var self = this;
      
      if ( $(self.when_cat).length <= 0 ){
        return false;
      }

      self.user_chart();
    },

    user_chart : function () {
      var self = this;

      if ( $('div.user-activity-chart').length <= 0 ){
        return false;
      }

      $.getJSON(self.data_path, function (data) {

        for (var i = 0; i < data.length; i++) {
          data[i].date = new Date(data[i].date*1000)
        }

        MG.data_graphic({
          
          data: data,
          width: $('.panel-wgt').width() - 40,
          height: 250,
          target: ".user-activity-chart",
          x_extended_ticks: true,
          x_accessor: "date",
          y_accessor: "value",
          interpolate: "liniar"
        });

      });
      
    }

  }).init();
});
