--Geometri Değiştirme Fonksiyonları
select st_astext(st_force2d('POINT(32 36 0)'::geometry)); --z değeri yok edildi

update spatialdata set geom = st_setsrid(geom,4326) where st_srid(geom)=0; --srid'si 0 olanları, 4326 olarak tanımla
--burada projeksiyon dönüşümü yapılmıyor, proj. bilinen bir verinin proj. tanımlanıyor
select st_srid(geom) from spatialdata where st_srid(geom) !=4326;

--Projeksiyon dönüşümü
select st_transform(geom, 3857) from spatialdata;
--3857:Google Maps'in projeksiyonunu tanımlar ve meriktir

select st_x(geom), st_x(st_transform(geom, 3857)) from spatialdata where st_geometrytype(geom) = 'ST_Point';

alter table spatialdata add column geom3 geometry;

update spatialdata set geom3=st_transform(geom,3857);
--geom kolonunun projeksiyonunu, 3857 olarak, geom3 kolonuna yazdırdık
select st_srid(geom), st_srid(geom3) from spatialdata;