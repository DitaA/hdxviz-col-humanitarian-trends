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
			type: 'area-spline',
			colors: {
				total: colorPalette[1]
			},
			names: {
				date: "Date",
				total_idps: "IDPs"
			}
		},
		axis: {
			x: {
				show: true,
				type: 'timeseries',
				tick: {
					format: '%b %Y',
					count: 10
				}
			},
			y: {
				show: false,
				label: {
					text: "Number of IDPs",
					position: "outer-center",
				},
				tick: {
					format: d3.format(","),
					culling: {
						max: 4
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
		},
		point: {
			show: false
		},
		tooltip: {
	        format: {
	            title: d3.time.format('%B %Y')
	            }
	       },
	    regions: [
	        {axis: 'x', start: '2012-11-01', end: '2013-12-31', class: 'negotiations'}
	    ],
	    grid: {
	      y: {
	        lines: [
	          {value: 15400, text: 'Average from Nov. 2012 to Dec. 2013.', axis: 'y'},
	          {value: 25643, text: 'All time average.', axis: 'y'}
	          ]
	         }
        }
	});
};