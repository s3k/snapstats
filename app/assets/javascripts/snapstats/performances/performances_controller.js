$(document).ready(function () {
  ({

    when_cat : "li.section-performance",
    data_path : ($(location).attr('pathname') + '/chart').replace('//', '/'),

    torso : { width : 375, height : 200, right : 20 },

    init : function () {
      var self = this;
      
      if ( $(self.when_cat).length <= 0 ){
        return false;
      }

      self.draw_chart();
    },

    draw_chart : function () {
        var self = this;

        $.getJSON(self.data_path, function (data) {

          for (var i = 0; i < data.data.length; i++) {
            for (var j = 0; j < data.data[i].length; j++) {
              data.data[i][j].date = new Date(data.data[i][j].date*1000)
            }
          }

          MG.data_graphic({
            data: data.data,
            full_width: true,
            height: self.torso.height * 3 / 2,
            right: self.torso.right,
            x_extended_ticks: true,
            target: '.chart-performance',
            x_accessor: 'date',
            y_accessor: 'value',
            interpolate: "liniar",
            // y_label: "milliseconds",
            legend: data.legend,
            legend_target: '.legend'
          });

        });
    }

  }).init();
});
