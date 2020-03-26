var all_crime_map;
var category1_crime_map;
var category2_crime_map;
var category3_crime_map;
var category4_crime_map;
var category5_crime_map;

function generateReportMap(divnamestring, jsondata, category, type, metric_type = "Total"){
	var map = L.map(divnamestring, {
	  maxBounds: [[39.767021, -75.380308], [40.237943, -74.855750]],
		scrollWheelZoom: false,
		minZoom: 10,
		dragging: !L.Browser.mobile
	}).fitBounds([[39.867021, -75.280308], [40.137943, -74.955750]]);
	map.setMinZoom(map.getBoundsZoom(map.options.maxBounds));

  var basemap = new L.StamenTileLayer('toner-lite');
	map.addLayer(basemap);

  var control = L.control.layers(null, null, {collapsed: false});
	control.addTo(map);

  $(window).on('resize', function() {
	  $(divnamestring).height($(window).height()).width($(window).width());
	  map.invalidateSize();
	}).trigger('resize');

	var data = jsondata;

	var geodata = $.ajax({url:'./assets/js/geom/police_districts.geojson',
	dataType: 'json'
	});

	$.when(geodata.done(function(){
	var years = [];
	for(i=0; i < data.length; i++){
		if(years.indexOf(data[i].Year) === -1){
		years.push(data[i].Year);
		}
	};

	for(i=0; i < years.length; i++){
		yearlyMapData = {type: 'FeatureCollection', features: [],};
		var yeardata = data.filter(d=> d.Year === years[i]);
		var districts = geodata.responseJSON;
		districts.features.forEach(function(item){
		  item.properties['Year'] = yeardata.filter(d=> d.dc_district === item.properties.dc_district)[0].Year;
		  item.properties['Count'] = yeardata.filter(d=> d.dc_district === item.properties.dc_district)[0].count;
		  item.properties['popupContent'] = '<pop2>' + category + ': ' + type + '</pop2><pop1>District ' + item.properties.dc_district + '</pop1><pop3><strong>' + item.properties.Year + ' ' + metric_type + ':</strong> ' + item.properties.Count + '</pop3>';
      yearlyMapData.features.push(JSON.parse(JSON.stringify(item)));
		});

    var jsonLayer = JSON.parse(JSON.stringify(yearlyMapData));

		var mapLayer = L.choropleth(jsonLayer, {
		  valueProperty: 'Count',
		  scale: ['#F4FFFF','#0f4d90'],
		  steps: 10,
		  mode: 'q',
		  style: {
			color: '#fff',
			weight: 1,
			opacity: 1,
			fillOpacity: 0.8
		},
		onEachFeature: function(feature, layer) {
			layer.bindPopup(feature.properties.popupContent);
			layer.on({
			mouseover: function highlightFeature(e) {
				var layer = e.target;
				layer.setStyle({
				weight: 2.5,
				color: '#fff',
				opacity: 1
				});
				layer.bringToFront();
			},
			mouseout: function resetHighlight(e) {
				var layer = e.target;
				layer.setStyle({
				weight: 1,
				color: '#fff',
				opacity: 0.8
				});
			}
			},
		)
		}
	});
	control.addBaseLayer(mapLayer, years[i]).addTo(map);
	if(years[i] === years[years.length - 1]){mapLayer.addTo(map)};
	}
	}));
	
	switch(divnamestring){
	  case 'allcrime':
	    all_crime_map = map;
	    break;
	  case 'category1crime':
	    category1_crime_map = map;
	    break;
	  case 'category2crime':
	    category2_crime_map = map;
	    break;
	  case 'category3crime':
	    category3_crime_map = map;
	    break;
	  case 'category4crime':
	    category4_crime_map = map;
	    break;
	  case 'category5crime':
	    category5_crime_map = map;
	    break;
	}
}

// Clears and resizes map on tab change. Fixes problem of bad map loading when resizing windows.
$(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
    if (typeof all_crime_map !== 'undefined'){all_crime_map.invalidateSize();}
    if (typeof category1_crime_map !== 'undefined'){category1_crime_map.invalidateSize();}
    if (typeof category2_crime_map !== 'undefined'){category2_crime_map.invalidateSize();}
    if (typeof category3_crime_map !== 'undefined'){category3_crime_map.invalidateSize();}
    if (typeof category4_crime_map !== 'undefined'){category4_crime_map.invalidateSize();}
    if (typeof category5_crime_map !== 'undefined'){category5_crime_map.invalidateSize();}
  })