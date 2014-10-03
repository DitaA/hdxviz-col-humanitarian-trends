//// mapping element
// this mapping element uses MapBox + Leaflet to map
// data stored in the idps data.
// it only shows a choropleth map with the latest data.

var mapboxTiles = L.tileLayer('https://{s}.tiles.mapbox.com/v3/luiscapelo.jlpda14n/{z}/{x}/{y}.png', {
    attribution: '<a href="http://www.mapbox.com/about/maps/" target="_blank">Terms &amp; Feedback</a>',
    maxZoom: 7
});

var map = L.map('map')
    .addLayer(mapboxTiles)
    .setView([15.63383, 12.15022], 5);

// creating a popup data
var popup = new L.Popup({ autoPan: false });

// statesData comes from the 'idps_data.js' script included above
var statesLayer = L.geoJson(statesData,  {
    style: getStyle,
    onEachFeature: onEachFeature
}).addTo(map);

  function getStyle(feature) {
      return {
          weight: 2,
          opacity: 0.1,
          color: 'black',
          fillOpacity: 0.7,
          fillColor: getColor(feature.properties.July2014)
      };
  }

  // get color depending on population density value
  function getColor(d) {
      return d > 20000 ? '#b10026' :
          d > 15000  ? '#e31a1c' :
          d > 10000  ? '#fc4e2a' :
          d > 5000  ? '#fd8d3c' :
          d > 3000   ? '#feb24c' :
          d > 2000   ? '#fed976' :
          d > 1000   ? '#ffffb2' :
          '#ffffe5';
  }

  // Excuse the short function name: this is not setting a JavaScript
  // variable, but rather the variable by which the map is colored.
  // The input is a string 'name', which specifies which column
  // of the imported JSON file is used to color the map.
  function setVariable(name) {
      var scale = ranges[name];
      usLayer.eachLayer(function(layer) {
          // Decide the color for each state by finding its
          // place between min & max, and choosing a particular
          // color as index.
          var division = Math.floor(
              (hues.length - 1) *
              ((layer.feature.properties[name] - scale.min) /
              (scale.max - scale.min)));
          // See full path options at
          // http://leafletjs.com/reference.html#path
          layer.setStyle({
              fillColor: hues[division],
              fillOpacity: 0.8,
              weight: 0.5
          });
      });
  };

  function onEachFeature(feature, layer) {
      layer.on({
          mousemove: mousemove,
          mouseout: mouseout,
          click: zoomToFeature
      });
  }

  var closeTooltip;

  function mousemove(e) {
      var layer = e.target;

      popup.setLatLng(e.latlng);
      popup.setContent('<div class="marker-title">' + "IDPs in " + layer.feature.properties.Name + ": " + "<span>" + layer.feature.properties.July2014 + "</span>" + '</div>' + "<i>July 2014</i>");

      if (!popup._map) popup.openOn(map);
      window.clearTimeout(closeTooltip);

      // highlight feature
      layer.setStyle({
          weight: 3,
          opacity: 0.3,
          fillOpacity: 0.9
      });

      if (!L.Browser.ie && !L.Browser.opera) {
          layer.bringToFront();
      }
  }

  function mouseout(e) {
      statesLayer.resetStyle(e.target);
      closeTooltip = window.setTimeout(function() {
          map.closePopup();
      }, 100);
  }

  function zoomToFeature(e) {
      map.fitBounds(e.target.getBounds());
  }

  var legend = L.control({position: 'topright'});

  legend.onAdd = function (map) {

      var div = L.DomUtil.create('div', 'info legend'),
          grades = [0, 1000, 2000, 3000, 5000, 10000, 15000, 20000],
          labels = [];

      // loop through our density intervals and generate a label with a colored square for each interval
      for (var i = 0; i < grades.length; i++) {
          div.innerHTML +=
              '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
              grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
      }

      // return '<span>Number of IDPs</span><br/>' + labels.join('');
      return div;
  };

  legend.addTo(map);