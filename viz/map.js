/// adding mapbox map
L.mapbox.accessToken = 'pk.eyJ1IjoibHVpc2NhcGVsbyIsImEiOiJZeFo3b0pNIn0.45gYdbaSP04kpEIuLwSA9w';
var map = L.mapbox.map('map', 'luiscapelo.jlpda14n', {
        attributionControl: false,
        infoControl:true
    });

// for the tooptip ti follow cursor
map.gridControl.options.follow = true;

// for setting the center point
map.setView([3, -66], 6);