ogr2ogr -sql "select admin_3.*, idp_map_data.* from 'admin_3.geojson' left join '../data/idp_map_data.csv'.pcode on admin_3.CODANE = idp_map_data.pcode" ../data/geo/output.geojson admin_3.geojson -f "GeoJSON"