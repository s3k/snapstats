$(document).ready(function () {
  ({

    when_cat : "li.section-main",
    data_path : '/snap/main/chart', //$(location).attr('pathname') + '/main/chart',

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

        for (var i = 0; i < data.length; i++) {
          data[i].date = new Date(data[i].date*1000)
        }

        MG.data_graphic({
          // title: "UFO Sightings",
          // description: "Yearly UFO sightings from 1945 to 2010.",
          data: data,
          // markers: [{'year': new Date(1425739266*1000), 'label': new Date(1425739266*1000)}],
          width: $('.panel-wgt').width() - 40,
          height: 250,
          target: ".chart",
          x_extended_ticks: true,
          x_accessor: "date",
          y_accessor: "value",
          interpolate: "liniar"
        });

      });

    }

  }).init();
});



	
	