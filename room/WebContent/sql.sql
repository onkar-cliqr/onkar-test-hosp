CREATE TABLE vendor (
   ID  SERIAL PRIMARY KEY,
   NAME           TEXT      NOT NULL,
   ADDRESS        TEXT 
);


CREATE TABLE users (
   ID  SERIAL PRIMARY KEY,
   vendor INT references vendor (ID),
   NAME           TEXT      NOT NULL,
   ADDRESS        TEXT  ,
   ACTIVE    boolean default true
);


CREATE TABLE rooms (
   ID  SERIAL PRIMARY KEY,
   NAME           TEXT      NOT NULL
);

CREATE TABLE room_category (
   ID  SERIAL PRIMARY KEY,
   NAME           TEXT      NOT NULL
);

CREATE TABLE room_category_parameter (
   ID  SERIAL PRIMARY KEY,
   room_category INT references room_category (ID),
   NAME           TEXT      NOT NULL
);



CREATE TABLE transaction (
   ID  SERIAL PRIMARY KEY,
   users INT references users (ID),
   rooms INT references rooms (ID),
   room_category_parameter INT references room_category_parameter (ID),
    checked boolean ,
    validated boolean ,
   day DATE NOT NULL
);



ALTER TABLE transaction ADD CONSTRAINT record_unique UNIQUE (nursingsupervisor, rooms, room_category_parameter, day   ,     housekeepingsupervisor );



/*Insert in to Room Catetgory*/
insert into "public"."room_category" ("name") values('Door Entry')
insert into "public"."room_category" ("name") values('Floors ,Walls ,Ceili...')
insert into "public"."room_category" ("name") values('Bed -Making')
insert into "public"."room_category" ("name") values('Bed -making Articles')
insert into "public"."room_category" ("name") values('Furniture')
insert into "public"."room_category" ("name") values('Lights')
insert into "public"."room_category" ("name") values('Bathrooms')
insert into "public"."room_category" ("name") values('Bathroom Articles')
insert into "public"."room_category" ("name") values('Air- conditioner')
insert into "public"."room_category" ("name") values('Refrigerator')
insert into "public"."room_category" ("name") values('Colour coding bins')
insert into "public"."room_category" ("name") values('Other articles')

/*Insert in to Room Catetgory parameter*/
insert into "room_category_parameter" ("name","room_category") values('Door is neat and clean',1)
insert into "public"."room_category_parameter" ("name","room_category") values('Door handle is in good working condition',1)
insert into "public"."room_category_parameter" ("name","room_category") values('Door is self-closing',1)
insert into "public"."room_category_parameter" ("name","room_category") values('Floors  are clean and dust-free',2)
insert into "public"."room_category_parameter" ("name","room_category") values('Walls are neat and tidy',2)
insert into "public"."room_category_parameter" ("name","room_category") values('Ceilings should be free of dust',2)
insert into "public"."room_category_parameter" ("name","room_category") values('Check all the corners,under bed surfaces ,behind',2)
insert into "public"."room_category_parameter" ("name","room_category") values('the doors,around the furniture for dust free',2)
insert into "public"."room_category_parameter" ("name","room_category") values('condition',2)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the electronic bed is working properly.',3)
insert into "public"."room_category_parameter" ("name","room_category") values('Bed should be uniformly spread',3)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the bed for dirt and dust free condition',3)
insert into "public"."room_category_parameter" ("name","room_category") values('Beds are stain free',3)
insert into "public"."room_category_parameter" ("name","room_category") values('Flat sheets',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Ordinary pillow cover',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Deck pillow cover',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Neck roll pillow cover',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Euroshams',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Baby sheets',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Duvet',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Baby pillow cover',4)
insert into "public"."room_category_parameter" ("name","room_category") values('Ensure all  furnitures are dust free',5)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the TV working condition',5)
insert into "public"."room_category_parameter" ("name","room_category") values('TV remote is working and in proper place',5)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the telephone for dust free and working',5)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the cleanliness of table,chair and sofa',5)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the cleanliness of jug, glass. And tray',5)
insert into "public"."room_category_parameter" ("name","room_category") values('Ensure lights are free of dust',6)
insert into "public"."room_category_parameter" ("name","room_category") values('Turn all lights to know they are working',6)
insert into "public"."room_category_parameter" ("name","room_category") values('All switches areclean and neat',6)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the floors ,walls and ceiling and should be',7)
insert into "public"."room_category_parameter" ("name","room_category") values('free of dirt and hair',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Free of odour',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the flush to ensure cleanliness',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Wash basin is clean and no leakage',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Mirror is clean',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the cloth hook',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Exhaust fans',7)
insert into "public"."room_category_parameter" ("name","room_category") values('Toilet paper',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Soap',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Shampoo',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Brush',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Bucket and mug',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Hand towel',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Bath towels',8)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the air cooling and remote is in good status',9)
insert into "public"."room_category_parameter" ("name","room_category") values('Check the working of refrigerator',10)
insert into "public"."room_category_parameter" ("name","room_category") values('Bins are kept clean and properly',11)
insert into "public"."room_category_parameter" ("name","room_category") values('Religious books',12)
insert into "public"."room_category_parameter" ("name","room_category") values('Fruits',12)
insert into "public"."room_category_parameter" ("name","room_category") values('Tissue box',12)
insert into "public"."room_category_parameter" ("name","room_category") values('Mineral water',12)


drop table transaction;
drop table room_category_parameter;
drop table room_category;
drop table rooms;
drop table users;
drop table vendor;



/*delete statement*/
delete from "public"."room_category_parameter" where "id"=56


insert into transaction (date,rooms,checked,room_category_parameter,users) values('15/05/2016',6,'false',5_4,1)

select room_category.id as roomid,room_category.name ,room_category_parameter.id as roomcatid,room_category_parameter.name from room_category,room_category_parameter where room_category.id=room_category_parameter.room_category


select * from rooms where id NOT IN  (select distinct rooms from transaction where datevalidated='05/18/2016')

select * from tabs where id in (select id from tabpermission where roles=1)

select * from rooms where id not in (select rooms from transaction where datevalidated='05/21/2016')

select * from rooms where id in (select rooms from transaction where datevalidated='05/21/2016' and nursingsupervisor IS NULL)

update transaction set datevalidated='05/22/2016',rooms=6,checked=false,room_category_parameter=52,nursingsupervisor=4 where datevalidated='05/22/2016' and rooms=6 and room_category_parameter=52

select tabs.id,tabs.name as tabname,roles.name as rolename from tabpermission,tabs,roles where tabs.id=tabpermission.tabs and roles.id=tabpermission.roles and roles.id!=2


delete from users where id=6

select distinct(datevalidated) from transaction union select count(*)>0 as diff,rooms.name,transaction.datevalidated from transaction,rooms where ((transaction.checked=true and transaction.validated=false) or (transaction.checked=false and transaction.validated=true)) and  rooms.id=transaction.rooms and transaction.datevalidated between '05/20/2016' and '05/25/2016'    group by transaction.datevalidated,rooms.name

select *  from (select count(*)>0 as diff,rooms.name,transaction.datevalidated from transaction,rooms where (transaction.checked=false or transaction.validated=false) and  rooms.id=transaction.rooms and transaction.datevalidated between '05/20/2016' and '05/25/2016'    group by transaction.datevalidated,rooms.name) AS t
RIGHT   JOIN (SELECT generate_series(min(datevalidated), max(datevalidated), '1d')::date as datevalidated
   FROM   transaction) AS x USING (datevalidated)
   
   select id ,datevalidated, 
   case
   when checked<>validated then 'true'
   else
   'false'
   end  
   from transaction 

   select  distinct datevalidated,checked =validated as diff from transaction where datevalidated not in (select datevalidated from (select  distinct datevalidated,checked =validated as diff from transaction) AS x where x.diff=false)
   
   select transaction.checked =transaction.validated as diff,rooms.name,transaction.datevalidated from transaction,rooms where rooms.id=transaction.rooms group by diff,rooms.name,transaction.datevalidated 

select diff,checked,validated , datevalidated,rooms from (SELECT x.datevalidated, t.checked,t.validated,t.checked=t.validated as diff,t.rooms
FROM 
   (SELECT generate_series(min(datevalidated), max(datevalidated), '1d')::date as datevalidated
   FROM   transaction) AS x
LEFT   JOIN transaction t USING (datevalidated,rooms)
group by x.datevalidated,t.checked,t.validated,t.rooms) as foo


 SELECT generate_series(min(datevalidated), max(datevalidated), '1d')::date AS thedate
   FROM   transaction
 

   select datevalidated, validated from transaction where validated not in (select checked from transaction)
   
   
   select *,
   case
   when checked=true and validated =true then '0'
   when checked=true and validated =false then 'false'
   when checked=false and validated =true then 'false'
   when checked=false and validated =false then 'false'
   end
   from transaction
   
   
   
   select * from (SELECT x.datevalidated, t.checked,t.validated,t.checked=t.validated as diff,t.rooms
FROM 
   (SELECT generate_series(min(datevalidated), max(datevalidated), '1d')::date as datevalidated
   FROM   transaction) AS x
LEFT   JOIN transaction t USING (datevalidated,rooms)


select validated,datevalidated from transaction where (checked=true and validated=true) or (checked=false and validated=false) or (checked=true and validated=false) or (checked=false and validated=true) group by datevalidated,validated


 select  distinct checked,validated,datevalidated from transaction order by datevalidated,checked,validated DESC
 
 select checked as diff,datevalidated from transaction where checked=false group by datevalidated,checked
 union
 select validated as diff,datevalidated from transaction where validated=false group by datevalidated,validated
 
 
 
 
select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where (validated=true and checked=true) and  datevalidated between '07/30/2016' and '07/07/2016' and datevalidated not in ( select datevalidated from transaction where checked=false and datevalidated between '07/30/2016' and '07/07/2016' group by datevalidated,checked,rooms
 union
 select datevalidated from transaction where validated=false and datevalidated between '07/30/2016' and '07/07/2016' group by datevalidated,validated,rooms
) group by datevalidated,validated,checked,rooms
union
select checked as diff,datevalidated,rooms from transaction where checked=false and datevalidated between '07/30/2016' and '07/07/2016' group by datevalidated,checked,rooms
 union
 select validated as diff,datevalidated,rooms from transaction where validated=false and datevalidated between '07/30/2016' and '07/07/2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms
 
 
 SELECT generate_series(to_date('05/20/2016','MM/DD/YYYY'),to_date('05/29/2016','MM/DD/YYYY') , '1d')::date
 

  diff  datevalidated name   
 ----- ------------- ------ 
 true  2016-05-22    ROOM_1
 false 2016-05-25    ROOM_1
 false 2016-05-24    icu_1 

 
 
 
  select name,datevalidated,diff
  from (select rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('05/20/2016','MM/DD/YYYY'),to_date('05/29/2016','MM/DD/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate
  left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where (validated=true and checked=true) and  datevalidated between '05/20/2016' and '05/25/2016' and datevalidated not in ( select datevalidated from transaction where checked=false and datevalidated between '05/20/2016' and '05/25/2016' group by datevalidated,checked,rooms
 union
 select datevalidated from transaction where validated=false and datevalidated between '05/20/2016' and '05/25/2016' group by datevalidated,validated,rooms
) group by datevalidated,validated,checked,rooms
union
select checked as diff,datevalidated,rooms from transaction where checked=false and datevalidated between '05/20/2016' and '05/25/2016' group by datevalidated,checked,rooms
 union
 select validated as diff,datevalidated,rooms from transaction where validated=false and datevalidated between '05/20/2016' and '05/25/2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms
 
 )as datediff using (name,datevalidated) order by name
 
 select name,datevalidated,diff from (select rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('05/20/2016','MM/DD/YYYY'),to_date('05/22/2016','MM/DD/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where (validated=true and checked=true) and  datevalidated between '05/20/2016' and '05/22/2016' and datevalidated not in ( select datevalidated from transaction where checked=false and datevalidated between '05/20/2016' and '05/20/2016' group by datevalidated,checked,roomsunionselect datevalidated from transaction where validated=false and datevalidated between '05/20/2016' and '05/22/2016' group by datevalidated,validated,rooms) group by datevalidated,validated,checked,roomsunionselect checked as diff,datevalidated,rooms from transaction where checked=false and datevalidated between '05/20/2016' and '05/22/2016' group by datevalidated,checked,roomsunionselect validated as diff,datevalidated,rooms from transaction where validated=false and datevalidated between '05/20/2016' and '05/22/2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms )as datediff using (name,datevalidated) order by name
 
 
 select id,name,datevalidated,diff from (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('04/27/2016','MM/DD/YYYY'),to_date('05/27/2016','MM/DD/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where (validated=true and checked=true) and  datevalidated between '04/27/2016' and '05/27/2016' and datevalidated not in ( select datevalidated from transaction where checked=false and datevalidated between '04/27/2016' and '04/27/2016' group by datevalidated,checked,rooms union select datevalidated from transaction where validated=false and datevalidated between '04/27/2016' and '05/27/2016' group by datevalidated,validated,rooms ) group by datevalidated,validated,checked,rooms union select checked as diff,datevalidated,rooms from transaction where checked=false and datevalidated between '04/27/2016' and '05/27/2016' group by datevalidated,checked,rooms union select validated as diff,datevalidated,rooms from transaction where validated=false and datevalidated between '04/27/2016' and '05/27/2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms )as datediff using (name,datevalidated) order by name

select transaction.id,transaction.checked,transaction.validated,users.name,transaction.datevalidated from transaction,users,room_category_parameter where rooms=6 and datevalidated='2016-05-24' and room_category_parameter.id=transaction.room_category_parameter and users.id=nursingsupervisor and users.id=housekeepingsupervisor

select tlist.id,tlist.checked,tlist.validated,tlist.datevalidated,users.name,tlist.housekeepingsupervisor from (select * from transaction where rooms=6 and datevalidated='2016-05-24') as tlist ,users where users.id=tlist.nursingsupervisor and users.id=tlist.housekeepingsupervisor   
 


select unm.name as unm,uhm,rcn, rcpn,uh,un,checked,validated from (select unid,uhm.name as uhm,rcn, rcpn,uh,un,checked,validated from (select uhid,unid,rc.name as rcn, rcpn,uh,un,checked,validated from (SELECT rcp.room_category as rcid,tlist.id,un.id as unid,uh.id as uhid,uh.name as uh,rm.name as rn,rcp.name as rcpn,tlist.checked,tlist.validated,tlist.datevalidated,un.name as un
FROM (select * from transaction where rooms=4 and datevalidated='2016-05-28') as tlist
JOIN users AS uh ON uh.id = tlist.housekeepingsupervisor
JOIN users AS un ON un.id = tlist.nursingsupervisor
JOIN room_category_parameter AS rcp ON rcp.id = tlist.room_category_parameter
JOIN rooms AS rm ON rm.id = tlist.rooms) as tlgetrc
JOIN room_category AS rc ON tlgetrc.rcid = rc.id) as tlgetmn
JOIN users AS uhm ON tlgetmn.uhid = uhm.manager) as tlgetunm
JOIN users AS unm ON tlgetunm.unid = unm.manager

select unm.name as unm,uhm,rcn, rcpn,uh,un,checked,validated from (select unid,uhm.name as uhm,rcn, rcpn,uh,un,checked,validated from (select uhid,unid,rc.name as rcn, rcpn,uh,un,checked,validated from (SELECT rcp.room_category as rcid,tlist.id,un.id as unid,uh.id as uhid,uh.name as uh,rm.name as rn,rcp.name as rcpn,tlist.checked,tlist.validated,tlist.datevalidated,un.name as un FROM (select * from transaction where rooms=1 and datevalidated='2016-05-28') as tlist JOIN users AS uh ON uh.id = tlist.housekeepingsupervisor JOIN users AS un ON un.id = tlist.nursingsupervisor JOIN room_category_parameter AS rcp ON rcp.id = tlist.room_category_parameter JOIN rooms AS rm ON rm.id = tlist.rooms) as tlgetrc JOIN room_category AS rc ON tlgetrc.rcid = rc.id) as tlgetmn JOIN users AS uhm ON tlgetmn.uhid = uhm.manager) as tlgetunm JOIN users AS unm ON tlgetunm.unid = unm.manager

select rc.name as rcn, rcpn,uh,un,checked,validated from (SELECT rcp.room_category as rcid,tlist.id,uh.name as uh,rm.name as rn,rcp.name as rcpn,tlist.checked,tlist.validated,tlist.datevalidated,un.name as un FROM (select * from transaction where rooms=4 and datevalidated='2016-05-28') as tlist JOIN users AS un ON un.id = tlist.housekeepingsupervisor JOIN users AS uh ON uh.id = tlist.nursingsupervisor JOIN room_category_parameter AS rcp ON rcp.id = tlist.room_category_parameter JOIN rooms AS rm ON rm.id = tlist.rooms) as tlgetrc JOIN room_category AS rc ON tlgetrc.rcid = rc.id



select unm.name as unm,uhm,rcn, rcpn,uh,un,checked,validated from 
(select unid,uhm.name as uhm,rcn, rcpn,uh,un,checked,validated from 
(select uhid,unid,rc.name as rcn, rcpn,uh,un,checked,validated from 
(SELECT rcp.room_category as rcpid,tlist.id,un.manager as unid,uh.manager as uhid,uh.name as uh,rm.name as rn,rcp.name as rcpn,tlist.checked,tlist.validated,tlist.datevalidated,un.name as un FROM 
(select * from transaction where datevalidated between '07-Jun-2016' and '07-Jun-2016' and nursingsupervisor=4) as tlist 
JOIN users AS uh ON uh.id = tlist.housekeepingsupervisor 
JOIN users AS un ON un.id = tlist.nursingsupervisor 
JOIN room_category_parameter AS rcp ON rcp.id = tlist.room_category_parameter 
JOIN rooms AS rm ON rm.id = tlist.rooms) as tlgetrc 
JOIN room_category AS rc ON tlgetrc.rcpid = rc.id) as tlgetmn 
JOIN users AS uhm ON tlgetmn.uhid = uhm.id) as  tlgetunm
JOIN users AS unm ON tlgetunm.unid = unm.id

select id,name,datevalidated,diff from (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('07-Apr-2016','dd/Mon/YYYY'),to_date('29-May-2016','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where (validated=true and checked=true) and  datevalidated between '29-Apr-2016' and '29-May-2016' and nursingsupervisor=4 and datevalidated not in ( select datevalidated from transaction where checked=false and nursingsupervisor=4 and datevalidated between '29-Apr-2016' and '29-May-2016' group by datevalidated,checked,rooms union select datevalidated from transaction where validated=false and nursingsupervisor=4 and datevalidated between '29-Apr-2016' and '29-May-2016' group by datevalidated,validated,rooms ) group by datevalidated,validated,checked,rooms union select checked as diff,datevalidated,rooms from transaction where checked=false and nursingsupervisor=4 and datevalidated between '29-Apr-2016' and '29-May-2016' group by datevalidated,checked,rooms union select validated as diff,datevalidated,rooms from transaction where validated=false and nursingsupervisor=4 and datevalidated between '29-Apr-2016' and '29-May-2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms )as datediff using (name,datevalidated) order by name


 create database testbase;
 
 
 
 use databse testbase;
 CREATE TABLE
    testbase.public.users
    (
        id INTEGER DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
        vendor INTEGER DEFAULT 1,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        active BOOLEAN DEFAULT true NOT NULL,
        first_name CHARACTER VARYING(50) NOT NULL,
        last_name CHARACTER VARYING(50) NOT NULL,
        email TEXT NOT NULL,
        pwd TEXT NOT NULL,
        role INTEGER NOT NULL,
        manager INTEGER NOT NULL,
        ismanager BOOLEAN,
        dateofbirth DATE,
        phonenumber CHARACTER VARYING(12),
        PRIMARY KEY (id),
        UNIQUE (name),
        UNIQUE (phonenumber),
        UNIQUE (first_name, last_name)
    );
    
    

    
    
    select id,name,datevalidated,diff from 
    (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated 
    from (SELECT generate_series(to_date('07-Jun-2016','dd/Mon/YYYY'),to_date('07-Jun-2016','dd/Mon/YYYY') , '1d')::date as datevalidated) 
    as dates,rooms) 
    as roomswithdate left join (select diff,datevalidated,name 
    from (select * 
    from (select * 
    from ( select validated=checked as diff, datevalidated,rooms 
    from transaction 
    where  (validated=true and checked=true) and  
    datevalidated between '07-May-2016' and '07-Jun-2016') and 
    datevalidated not in ( 
    select datevalidated from transaction 
    where  
    checked=false  and datevalidated between '07-May-2016' and '07-Jun-2016' 
    group by datevalidated,checked,rooms 
    union 
    select datevalidated from 
    transaction 
    where  
    validated=false  and datevalidated between '07-May-2016' and '07-Jun-2016' 
    group by datevalidated,validated,rooms ) 
    group by datevalidated,validated,checked,rooms union select checked as diff,datevalidated,rooms from transaction where  checked=false  and datevalidated between '07-May-2016' and '07-Jun-2016' group by datevalidated,checked,rooms union select validated as diff,datevalidated,rooms from transaction where  validated=false  and datevalidated between '07-May-2016' and '07-Jun-2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms )as datediff using (name,datevalidated) order by name
    
    
    
    
    select * 
    from (
    select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated from 
    (
    SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date 
    as datevalidated) 
    as dates,rooms) 
    as roomswithdate 
    left join (
    select diff,datevalidated,name 
    from 
    (
    select * from
    (
    select * from
    ( select 'true' as diff, datevalidated,rooms 
    from transaction 
    where hospital=1 and (validated=true and checked=true) 
    and  datevalidated between '08-May-2016' and '08-Jun-2016'  
    and rooms not in
    ( 
    select datevalidated,rooms from
    transaction 
    where hospital=1 and checked=false
    and datevalidated between '08-May-2016' and '08-Jun-2016' 
    group by datevalidated,checked,rooms 
    union
    select datevalidated,rooms from
    transaction
    where hospital=1 and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by datevalidated,validated,rooms )
    group by datevalidated,validated,checked,rooms
    union
    select checked as diff,datevalidated,rooms
    from transaction
    where hospital=1 and checked=false  
    and datevalidated between '08-May-2016' and '08-Jun-2016' 
    group by datevalidated,checked,rooms
    union
    select validated as diff,datevalidated,rooms
    from transaction
    where hospital=1 and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016' 
    group by datevalidated,validated,rooms )
    as f) 
    AS diffdates) 
    AS roomsouts,rooms
    where rooms.id=roomsouts.rooms )
    as datediff
    using (name,datevalidated) 
    order by name
    
    
     select id,name,datevalidated,diff from 
     
    
     select diff,datevalidated,rooms from
    transaction 
    where hospital=1
    and datevalidated between '08-May-2016' and '08-Jun-2016' and datevalidated='07-Jun-2016'
    and datevalidated in ( 
    select datevalidated from( 
    select checked=validated as diff,datevalidated,rooms from
    transaction 
    where hospital=1
    and datevalidated between '08-May-2016' and '08-Jun-2016' and datevalidated='07-Jun-2016'
    group by datevalidated,diff,rooms order by datevalidated,rooms) as dateall
    where diff=false group by datevalidated)
    
    group by datevalidated,diff,rooms order by datevalidated,rooms 
    
    
    
    
    select rooms from (
     select checked,datevalidated,rooms from
    transaction 
    where hospital=1 and checked=false
    and datevalidated between '08-May-2016' and '08-Jun-2016' 
    group by datevalidated,checked,rooms 
    union
    select validated,datevalidated,rooms from
    transaction
    where hospital=1 and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by datevalidated,validated,rooms ) as tab)
   	and datevalidated not in (
    select datevalidated from (
     select checked,datevalidated,rooms from
    transaction 
    where hospital=1 and checked=false
    and datevalidated between '08-May-2016' and '08-Jun-2016' 
    group by datevalidated,checked,rooms 
    union
    select validated,datevalidated,rooms from
    transaction
    where hospital=1 and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by datevalidated,validated,rooms ) as tab)
    group by datevalidated,diff,rooms 
    
    
    
    
    
    
     select checked,datevalidated,rooms from
    transaction 
    where hospital=1 and checked=false
    and datevalidated between '08-May-2016' and '08-Jun-2016' 
    group by datevalidated,checked,rooms 
    union
    select validated,datevalidated,rooms from
    transaction
    where hospital=1 and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by datevalidated,validated,rooms
    
    
    
    
    
    select * from
    (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated from 
    (SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date 
    as datevalidated) as dates ,rooms) as roomswithdate 
    where datevalidated not in (
    (select datevalidated,roomsid  from
    transaction 
    where hospital=1
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by datevalidated,rooms))
    
    using (id,datevalidated)
    
    
    select id,name,datevalidated,diff from (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where hospital=1 and (validated=true and checked=true) and  datevalidated between '08-May-2016' and '08-Jun-2016'  and datevalidated not in ( select datevalidated from transaction where hospital=1 and checked=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,checked,rooms union select datevalidated from transaction where hospital=1 and validated=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,validated,rooms ) group by datevalidated,validated,checked,rooms union select checked as diff,datevalidated,rooms from transaction where hospital=1 and checked=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,checked,rooms union select validated as diff,datevalidated,rooms from transaction where hospital=1 and validated=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms )as datediff using (name,datevalidated) order by name
    
    
    
    
    select id,name,datevalidated,diff from (select rooms.id as id,rooms.name as name, dates.datevalidated as datevalidated From (SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates,rooms) as roomswithdate left join (select diff,datevalidated,name from (select * from (select * from ( select validated=checked as diff, datevalidated,rooms from transaction where hospital=1 and (validated=true and checked=true) and  datevalidated between '08-May-2016' and '08-Jun-2016'  and datevalidated not in ( select datevalidated from transaction where hospital=1 and checked=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,checked,rooms union select datevalidated from transaction where hospital=1 and validated=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,validated,rooms ) group by datevalidated,validated,checked,rooms union select checked as diff,datevalidated,rooms from transaction where hospital=1 and checked=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,checked,rooms union select validated as diff,datevalidated,rooms from transaction where hospital=1 and validated=false  and datevalidated between '08-May-2016' and '08-Jun-2016' group by datevalidated,validated,rooms )as f) AS diffdates) AS roomsouts,rooms where rooms.id=roomsouts.rooms )as datediff using (name,datevalidated) order by name
    
    
    
    
     select * from
    (select rooms.id as roomsid,rooms.name as name, dates.datevalidated as datevalidated from 
    (SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date 
    as datevalidated) as dates ,rooms) as roomswithdate
    left join (
    --union true and false
    select * from (
    --true
    select * , true as diff from (
    select rooms as roomsid,datevalidated from transaction where (nursingsupervisor=25) EXCEPT (
    select rooms as roomsid,datevalidated  from
    transaction 
    where hospital=1 and (nursingsupervisor=25) and checked=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by roomsid,datevalidated
    union
    select rooms as roomsid,datevalidated  from
    transaction 
    where hospital=1  and (nursingsupervisor=25) and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by roomsid,datevalidated))as dumpd
    group by roomsid,datevalidated
    
    union
    --for fasle
     select rooms as roomsid,datevalidated ,false as diff from
    transaction 
    where hospital=1  and (nursingsupervisor=25) and checked=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by roomsid,datevalidated
    union
    select rooms as roomsid,datevalidated,false as diff  from
    transaction 
    where hospital=1 and (nursingsupervisor=25) and validated=false
    and datevalidated between '08-May-2016' and '08-Jun-2016'
    group by roomsid,datevalidated) as trueandfalse) as foo
    using (roomsid,datevalidated)
    
   
    select * from  (select rooms.id as roomsid,rooms.name as name, dates.datevalidated as datevalidated from (SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates ,rooms) as roomswithdate left join ( select * from (  select * , true as diff from ( select rooms as roomsid,datevalidated from transaction EXCEPT ( select rooms as roomsid,datevalidated  from transaction  where hospital=1 and checked=false and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated union select rooms as roomsid,datevalidated  from transaction where hospital=1 and validated=false and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated))as dumpd group by roomsid,datevalidated union  select rooms as roomsid,datevalidated ,false as diff from transaction  where hospital=1 and checked=false and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated union select rooms as roomsid,datevalidated,false as diff  from transaction  where hospital=1 and validated=false and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated) as trueandfalse) as foo using (roomsid,datevalidated)
   
    select * from  (select rooms.id as roomsid,rooms.name as name, dates.datevalidated as datevalidated from (SELECT generate_series(to_date('08-May-2016','dd/Mon/YYYY'),to_date('08-Jun-2016','dd/Mon/YYYY') , '1d')::date as datevalidated) as dates ,rooms) as roomswithdate left join ( select * from ( select * , true as diff from ( select rooms as roomsid,datevalidated from transaction EXCEPT ( select rooms as roomsid,datevalidated  from transaction  where hospital=1 and checked=false and (nursingsupervisor=25 or housekeepingsupervisor=25)  and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated union select rooms as roomsid,datevalidated  from transaction where hospital=1 and validated=false and (nursingsupervisor=25 or housekeepingsupervisor=25)  and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated))as dumpd group by roomsid,datevalidated union select rooms as roomsid,datevalidated ,false as diff from transaction  where hospital=1 and checked=false and (nursingsupervisor=25 or housekeepingsupervisor=25)  and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated union select rooms as roomsid,datevalidated,false as diff  from transaction  where hospital=1 and validated=false and (nursingsupervisor=25 or housekeepingsupervisor=25)  and datevalidated between '08-May-2016' and '08-Jun-2016' group by roomsid,datevalidated) as trueandfalse) as foo using (roomsid,datevalidated)
    
    
    