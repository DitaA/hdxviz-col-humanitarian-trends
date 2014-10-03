//// charting data
// this uses c3 (d3) to load the time series data from a CSV file
// then carts it into a time series

// Color Brewer Palette: #d53e4f, #f46d43, #fdae61, #fee08b, #ffffbf, #e6f598, #abdda4, #66c2a5, #3288bd
var colorPalette = ['#B2B2B2', '#007CE0'];
var timeSeriesChart = generateTimeseriesChart("#timeseries", "data/totalPerDate.csv");

/*
var timeseries = c3.generate({
  bindto: '#timeseries',
    data: {
      x: 'date',
      url: 'data/idp_total_data.csv',
      type: 'line',
      colors: {
        total: colorPalette[1]
      },
      names: {
        total: "Total Number of Internally Displaced Persons"
      }
    },
    axis: {
      x: {
        label: 'Time',
        type: 'timeseries',
          tick: {
            format: '%B, %Y'
          }
      },
      y: {
        label: 'Total Number of IDPs',
        show: true
      }
    },
    tooltip: {
      format: {
        value: d3.format(',')
      }
    },
    point: {
      show: true
    },
    size: {
      height: 300,
      width: 700
    },
    legend: {
      show: false
    }
});
*/

function generateTimeseriesChart(bindTo, dataUrl) {
	return c3.generate({
		bindto: bindTo,
		data: {
			url: dataUrl,
			x: 'date',
			type: 'line',
			colors: {
				total: colorPalette[1]
			},
			names: {
				date: "Date",
				total_idps: "Total Number of Internally Displaced Persons"
			}
		},
		axis: {
			x: {
				type: 'timeseries',
				tick: {
					format: '%b %Y',
					culling: {
						max:6
					}
				},
				label: {
					text: "Date",
					position: "outer-center"
				}
			},
			y: {
				label: {
					text: "Number of IDPs",
					position: "outer-center"
				},
				tick: {
					culling: {
						max: 5
					}
				}
			}
		},
		legend: {
			show: false
		},
		size: {
			height: 300
		},
		padding: {
			right: 20
		}		
	});
};