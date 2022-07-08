var map;
var mapWide;
var service;
var infowindow;
var searchBox;
var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;
var icons = {
	basic:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#8B44F0',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-postal-code"></span>'
	},
	restaurant:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#F1BF1E',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-restaurant"></span>'
	},
	bar:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#DE2C26',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-night-club"></span>'
	},
	cafe:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#926B25',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-cafe"></span>'
	},
	museum:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#888888',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-museum"></span>'
	},
	park:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#0C6916',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-park"></span>'
	},
	shopping_mall:{
		icon:{
			path:mapIcons.shapes.MAP_PIN,
			fillColor: '#44BCF0',
			fillOpacity:1,
			strokeColor:'',
			strokeWeight:0
		},
		map_icon_label : '<span class="map-icon map-icon-grocery-or-supermarket"></span>'
	}
	
};
var markers = [];
function initMap() {
	
	var sydney = new google.maps.LatLng(-33.867, 151.195);
	map = new google.maps.Map(document.getElementById('map'), {zoom:15, center:sydney});
	service = new google.maps.places.PlacesService(map);

	var cityRequest = { 
		query:"${ trvCityList[0].cityNameEn }",
		fields:[geometry]
	};
	console.log("${ trvCityList[0].cityNameEn }");
	service.findPlaceFromQuery(cityRequest, function(results, status) {
		if(status === google.maps.places.PlaceServiceStatus.OK) {
			map.setCenter(results[0].geometry.location);
		}
	})
	
	
	mapWide = new google.maps.Map(document.getElementById('mapWide'), {zoom:15, center:sydney});
	infowindow = new google.maps.InfoWindow();
	searchBox = new google.maps.places.SearchBox(document.getElementById('searchInput'));
	//map.controls[google.maps.ControlPosition.TOP_LEFT].push(document.getElementById('searchInput2'));
	map.controls[google.maps.ControlPosition.LEFT_TOP].push(document.getElementById('left-panel'));
	
	var cityMarkers = [
		{
			location:sydney, 
			icon:icons.basic.icon,
			map_icon_label:icons.basic.map_icon_label,
			info:'<h1>Sydney</h1><h5>NSW, Australia</h5>'
		}
	];

	map.addListener('bounds_changed', function() {
		searchBox.setBounds(map.getBounds());
	});

	searchBox.addListener('places_changed', function() {
		var places = searchBox.getPlaces();

		if(places.length === 0) {
			return;
		}

		//clear out the old markers
		markers.forEach(function(m) {
			//m.setMap(null);
		});
		markers = [];

		//for each place, get the icon, name, and location
		var bounds = new google.maps.LatLngBounds();

		places.forEach(function (p) {
			if(!p.geometry) {
				return;
			}
			//create marker for each place
			markers.push(new google.maps.Marker({
				map:map,
				title: p.name,
				position: p.geometry.location
			}));

			if(p.geometry.viewport) {
				//only geocodes have viewport
				bounds.union(p.geometry.viewport);
			}else {
				bounds.extend(p.geometry.location);
			}
		});
		map.fitBounds(bounds);
	});


	/*for(var i = 0; i < markers.length; i++) {
		addMarker(markers[i]);
	}*/
	
	//places result
	//basic:address_component, adr_address, formatted_address, geometry, icon, name, 
	//permanently_closed, photo, place_id, plus_code, type, url, utc_offset, vicinity
	//contact:formatted_phone_number, international_phone_number,opening_hours, website
	//atmosphere:rating, review, user_ratings_total
	
	
	var request = {
			query: 'Museum of Contemporary Art Australia',
			fields: ['name', 'icon', 'geometry', 'formatted_address', 'place_id', 'types'],
	};

	//service.findPlaceFromQuery(request, callback);


	/*google.maps.event.addListener(map, 'click', function(event) {
		addMarker({location:event.latLng});
	});*/
}



function placeTypeSearch(placeType) {
	
	var getNextPage = null;
	var moreBtn = document.getElementById('more');
	moreBtn.onclick = function() {
		moreBtn.disabled = true;
		if(getNextPage) getNextPage();
	};
	
	markers.forEach(function(marker) {
		marker.setMap(null);
	});
	var request = {
			location: map.getCenter(),
			radius: '1000',
			type: [placeType]
	};
	service.nearbySearch(request, function(results, status, pagination) {
		var bounds = new google.maps.LatLngBounds();
		var placeList = document.getElementById('placeList');
		if (status === google.maps.places.PlacesServiceStatus.OK) {
			for (var i = 0; i < results.length; i++) {
				var li = document.createElement('li');
//				li.classList.add('panel-block');
				li.textContent = results[i].name;
				li.classList.add('panel-block');
				placeList.appendChild(li);
				bounds.extend(results[i].geometry.location);
				addMarker({
					location:results[i].geometry.location,
					icon:icons[placeType].icon,
					map_icon_label:icons[placeType].map_icon_label,
					info: '<h1>' + results[i].name + "'</h1>" + results[i].formatted_address 
						+ ", (placeId : " + results[i].place_id + ")"
				});
			}
			map.fitBounds(bounds);
			moreBtn.disabled = !pagination.hasNextPage;
			getNextPage = pagination.hasNextPage && function() {
				pagination.nextPage();
			}
			map.setCenter(results[0].geometry.location);
		}else return;
	});
}


function addMarker(props) {
	var marker = new mapIcons.Marker({
		position: props.location,
		//label: labels[labelIndex++ % labels.length],
		icon:props.icon,
		map_icon_label:props.map_icon_label,
		map: map
	});
	
	markers.push(marker);
	/*if(props.icon) {
		marker.setIcon(props.icon);
	}*/
	if(props.info) {
		var infoWindow = new google.maps.InfoWindow({
			content:props.info
		});
		marker.addListener('click', function() {
			infoWindow.open(map, marker);
		});
	}
	
}