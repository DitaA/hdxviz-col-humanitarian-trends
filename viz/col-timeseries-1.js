//// charting data
// this uses c3 (d3) to load the time series data from a CSV file
// then carts it into a time series

// Color Brewer Palette: #d53e4f, #f46d43, #fdae61, #fee08b, #ffffbf, #e6f598, #abdda4, #66c2a5, #3288bd
var colorPalette = ['#B2B2B2', '#007CE0'];
var timeSeriesChart = generateTimeseriesChart("#timeseries", "data/totalPerDate.csv");

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
				total_idps: "IDPs",
				projection: "OCHA Projection"
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
	    grid: {
	      y: {
	        lines: [
	          {value: 16907, text: 'Average from Jan. 2010 to Dec. 2013.', axis: 'y'},
	          {value: 25643, text: 'Average from 1996 to present.', axis: 'y'}
	          ]
	         }
        }
	});
};