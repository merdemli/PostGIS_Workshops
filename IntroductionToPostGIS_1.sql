
--PostGIS Giriş

$$ LANGUAGE plpgsql, sql

create database workshop;
create extension postgis;

CREATE TABLE spatialdata
(
	id serial NOT NULL,
	geom geometry,
	CONSTRAINT pkey PRIMARY KEY (id)
)

SELECT AddGeometryColumn ('public','spatialdata','geom2',4326,'POINT',2); 
--public şeması altında, spatialdata tablosuna, geom2 isminde,
--coğrafi projeksiyonda tanımlı, nokta tipi ve 2 boyutlu kolon eklendi

insert into spatialdata(geom)
select st_geomfromtext('Point(32.86186 39.9090847)', 4326);

insert into st_setsrid(
			st_makepoint(32.8618697,39.9090847),4326);       --projeksiyon tanımlanarak, nokta oluşturuldu.
			
	
insert into spatialdata(geom)
select st_geomfromgeojson('{"type":"Point","coordinates":[32.7703187,39.9449081]}')

insert into spatialdata(geom)
select st_geomfromkml('<Point><Coordinates>32.77031869999999,39.94490809999</Coordinates></Point>');

insert into spatialdata(geom)
select st_makeline
(	   st_geomfromtext('Point(32.8618697 39.9090847)',4326), st_geomfromtext('Point(33.8618697 39.9090847)',4326)
);

insert into spatialdata(geom)
select st_makepolygon(st_geomfromtext('Linestring(75.15 29.53 1, 77 29 1, 77.6 29.5 1, 75.15 29.53 1)'));












