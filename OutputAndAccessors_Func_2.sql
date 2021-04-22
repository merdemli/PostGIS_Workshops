--Çıktı Alma İşlemleri

 select st_astext(geom) from spatialdata;    --spatialdata tablosundaki geometrileri text formatında getirir
 select st_asgeojson(geom) from spatialdata;  -- geojson
 select st_askml(geom) from spatialdata where st_srid(geom)=4326; --srid'si 4326 olan geometrileri kml olarak getirir
 
 --GeoJSON Çıktı Alma
 
 SELECT jsonb_build_object(
    'type',     'FeatureCollection',
    'features', jsonb_agg(features)
)
FROM (
  SELECT jsonb_build_object(
    'type',       'Feature',
    'id',         id,
    'geometry',   ST_AsGeoJSON(geom)::jsonb,
    'properties', to_jsonb(inputs) - 'id' - 'geom'
  ) AS feature
  FROM (SELECT * FROM spatialdata) inputs) features;
  
  --1..Bu çıktıyı bir JSON formatter'da çalıştırdığımızda bize, tablomuzda bulunan verileri json formatında düzenlenmiş
  --olarak verir
  
  --2..Bu json dosyasını QGIS'te de açarak görüntüleyebiliriz
  
  --Geometry Accessors Function
  
  select st_geometrytype(geom) from spatialdata;
  select st_startpoint(geom) from spatialdata; -- Sadece LineString'in başlangıç noktasını döndürür.
  
  select st_x(st_endpoint(geom)) from spatialdata where st_geometrytype(geom)= 'ST_LineString'; 
  --line'a ait st_x değeri döner
  
 select st_x (st_endpoint(geom)) bitisX,
 st_y(st_endpoint(geom)) bitisY,				
 st_x(st_startpoint(geom)) baslangicX,
 st_y(st_startpoint(geom)) baslangıcY						
 from spatialdata where st_geometrytype(geom)='ST_LineString';
  --elimizdeki doğruların başlangıç ve bitiş notlarını döner
  
 select st_srid(geom) from spatialdata where st_srid(geom) !=4326;
 
select st_isvalid(st_geomfromtext('POLYGON((0 0, 1 1, 1 2, 1 1, 0 0))'));         --bool döner
--bir polygon geometrisi oluşturur m? 

select st_isvalidreason(st_geomfromtext('POLYGON((0 0, 1 1, 1 2, 1 1, 0 0))'));   --neden poligon oluşturmadığını döner

select '2'::text, '2'::integer,'2'::float;                  --casting for postgresql

select 'LINESTRING(0 0, 1 1, 2 2)'::geometry              --geometriye cast edildi, yani geometri tanımlandı ama projeksiyonu yoktur

select st_pointn('LINESTRING(0 0, 1 1, 2 2)'::geometry,3);   --bir line'ın n.noktasını getirir
  
select st_geometrytype(st_pointn('LINESTRING(0 0, 1 1, 2 2)'::geometry,3));  

select st_npoints('LINESTRING(0 0, 1 1, 2 2)'::geometry);   --bu line'ın kaç tane noktası var?, int döndürür

select ST_GeometryN(st_geomfromtext('MULTIPOINT(1 2,3 4,5 6,8 9)'),2); --??

select st_xmin(geom),
st_ymin(geom),
st_xmax(geom),									--indexleme mekanızmalarında kullanılır.
st_ymax(geom)									--bbox
from spatialdata where st_geometrytype(geom)='ST_Polygon' limit 1;


insert into spatialdata(geom)											
select st_envelope(geom) from spatialdata where st_geometrytype(geom)='ST_Polygon' limit 1; --sadece bir kayıt getirir
--spatialdata tablosundaki, geometrisi poligon olan datanın bbox'ını tabloya ekler
--Qgis'ten kontrol edilir


  
  
  
  
  
  
  
  
  
  
  
  
  
  