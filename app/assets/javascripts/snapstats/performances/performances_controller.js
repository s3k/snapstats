$(document).ready(function () {
  ({

    when_cat        : "li.section-performance",
    data_path       : ($(location).attr('pathname') + '/chart').replace('//', '/'),
    flat_data_path  : ($(location).attr('pathname') + '/flat_chart').replace('//', '/'),

    torso : { width : 375, height : 200, right : 20 },

    init : function () {
      var self = this;
      
      if ( $(self.when_cat).length <= 0 ){
        return false;
      }

      self.init_buttons();

      // self.draw_chart();
      self.draw_flat_chart();
    },

    init_buttons : function () {
      var self = this;

      $('.detail-chart').click(function () {
        self.draw_chart();
        
        $('.legend').show();
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
      });

      $('.total-chart').click(function () {
        self.draw_flat_chart();
        
        $('.legend').hide();
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
      });
    },

    draw_flat_chart : function () {
      var self = this;

      $.getJSON(self.flat_data_path, function (data) {

        for (var i = 0; i < data.length; i++) {
          data[i].date = new Date(data[i].date*1000)
        }

        MG.data_graphic({
          
          data: data,
          full_width: true,
          
          height: self.torso.height * 3 / 2,
          right: self.torso.right,

          target: ".chart-performance",
          x_extended_ticks: true,
          x_accessor: "date",
          y_accessor: "value",
          // y_scale_type:'log',
          interpolate: "linear"
        });
      });

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
            interpolate: "basic",
            y_scale_type:'linear',
            legend: data.legend,
            legend_target: '.legend',
            
            // y_label: "milliseconds",
            // y_extended_ticks: true,
            // yax_format: d3.time.format('%B'),
            
            // yax_units: 'ms '
          });

        });
    }

  }).init();
});
