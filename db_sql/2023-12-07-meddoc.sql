CREATE SEQUENCE "public".affiliationorder_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".appointment_avg_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".civility_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".communes_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".company_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".diagnostic_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".districts_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".event_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".event_type_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".healthpro_agenda_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".healthpro_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".healthpro_identifier_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".jwt_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".medicament_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".medicament_type_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".notification_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".otpvalidation_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".patient_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".patient_identifier_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".provinces_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".region_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".relationship_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".roles_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".speciality_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".symptom_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".typeofactivity_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".user_id_seq START WITH 1 INCREMENT BY 1;

CREATE  TABLE "public".affiliationorder ( 
	id                   integer DEFAULT nextval('affiliationorder_id_seq'::regclass) NOT NULL  ,
	description          varchar(255)  NOT NULL  ,
	CONSTRAINT pk_affiliationorder PRIMARY KEY ( id )
 );

CREATE  TABLE "public".civility ( 
	id                   integer DEFAULT nextval('civility_id_seq'::regclass) NOT NULL  ,
	description          varchar(255)  NOT NULL  ,
	CONSTRAINT pk_civility PRIMARY KEY ( id )
 );

CREATE  TABLE "public".diagnostic ( 
	id                   integer DEFAULT nextval('diagnostic_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)    ,
	CONSTRAINT diagnostic_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".event_type ( 
	id                   integer DEFAULT nextval('event_type_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	CONSTRAINT pk_event_type PRIMARY KEY ( id )
 );

CREATE  TABLE "public".medicament ( 
	id                   integer DEFAULT nextval('medicament_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	CONSTRAINT pk_medicament PRIMARY KEY ( id )
 );

CREATE UNIQUE INDEX unq_medicament_name ON "public".medicament ( name );

CREATE  TABLE "public".medicament_type ( 
	id                   integer DEFAULT nextval('medicament_type_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	CONSTRAINT pk_medicament_type PRIMARY KEY ( id ),
	CONSTRAINT unq_medicament_type_name UNIQUE ( name ) 
 );

CREATE  TABLE "public".provinces ( 
	id                   integer DEFAULT nextval('provinces_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)    ,
	CONSTRAINT pk_provinces PRIMARY KEY ( id )
 );

CREATE  TABLE "public".regions ( 
	id                   integer DEFAULT nextval('region_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)    ,
	province_id          integer  NOT NULL  ,
	CONSTRAINT pk_region PRIMARY KEY ( id ),
	CONSTRAINT fk_region_provinces FOREIGN KEY ( province_id ) REFERENCES "public".provinces( id )   
 );

CREATE  TABLE "public".relationship ( 
	id                   integer DEFAULT nextval('relationship_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)    ,
	CONSTRAINT relationship_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public"."role" ( 
	id                   integer DEFAULT nextval('roles_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	CONSTRAINT pk_roles PRIMARY KEY ( id )
 );

CREATE  TABLE "public".speciality ( 
	id                   integer DEFAULT nextval('speciality_id_seq'::regclass) NOT NULL  ,
	description          varchar(255)  NOT NULL  ,
	CONSTRAINT pk_speciality PRIMARY KEY ( id )
 );

CREATE  TABLE "public".symptom ( 
	id                   integer DEFAULT nextval('symptom_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)    ,
	CONSTRAINT symptom_pkey PRIMARY KEY ( id )
 );

CREATE UNIQUE INDEX unq_symptom_name ON "public".symptom ( name );

CREATE  TABLE "public".typeofactivity ( 
	id                   integer DEFAULT nextval('typeofactivity_id_seq'::regclass) NOT NULL  ,
	description          varchar(255)  NOT NULL  ,
	max_account_permitted integer  NOT NULL  ,
	identifier           varchar(255)  NOT NULL  ,
	CONSTRAINT pk_typeofactivity PRIMARY KEY ( id )
 );

CREATE  TABLE "public".company ( 
	id                   integer DEFAULT nextval('company_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)    ,
	nif                  varchar(255)  NOT NULL  ,
	stat                 varchar(255)  NOT NULL  ,
	typeofactivity_id    integer  NOT NULL  ,
	picture              varchar(255)    ,
	socialreason         varchar(255)    ,
	creationdate         date    ,
	images               varchar(255)    ,
	address              varchar(255)    ,
	CONSTRAINT pk_company PRIMARY KEY ( id ),
	CONSTRAINT fk_company_typeofactivity FOREIGN KEY ( typeofactivity_id ) REFERENCES "public".typeofactivity( id )   
 );

CREATE  TABLE "public".districts ( 
	id                   integer DEFAULT nextval('districts_id_seq'::regclass) NOT NULL  ,
	name                 varchar(100)  NOT NULL  ,
	region_id            integer  NOT NULL  ,
	CONSTRAINT pk_districts PRIMARY KEY ( id ),
	CONSTRAINT fk_districts_regions FOREIGN KEY ( region_id ) REFERENCES "public".regions( id )   
 );

CREATE  TABLE "public".healthpro ( 
	id                   integer DEFAULT nextval('healthpro_id_seq'::regclass) NOT NULL  ,
	name                 varchar(255)    ,
	identifier           varchar(255)    ,
	affiliation_order_id integer    ,
	order_num            varchar(255)    ,
	speciality_id        integer    ,
	company_id           integer    ,
	birth_date           timestamp    ,
	first_name           varchar(255)    ,
	civility             varchar(255)    ,
	typeofactivity_id    integer    ,
	description          text    ,
	CONSTRAINT healthpro_pkey PRIMARY KEY ( id ),
	CONSTRAINT unq_healthpro_identifier UNIQUE ( identifier ) ,
	CONSTRAINT fk_healthpro_affiliationorder FOREIGN KEY ( affiliation_order_id ) REFERENCES "public".affiliationorder( id )   ,
	CONSTRAINT fk_healthpro_company FOREIGN KEY ( company_id ) REFERENCES "public".company( id )   ,
	CONSTRAINT fk_healthpro_speciality FOREIGN KEY ( speciality_id ) REFERENCES "public".speciality( id )   ,
	CONSTRAINT fk_healthpro_typeofactivity FOREIGN KEY ( typeofactivity_id ) REFERENCES "public".typeofactivity( id )   
 );

CREATE INDEX unq_healthpro_speciality_id ON "public".healthpro  ( speciality_id );

CREATE  TABLE "public".typeactivity_speciality ( 
	typeofactivity_id    integer  NOT NULL  ,
	speciality_id        integer  NOT NULL  ,
	CONSTRAINT fk_typeactivity_speciality_speciality FOREIGN KEY ( speciality_id ) REFERENCES "public".speciality( id )   ,
	CONSTRAINT fk_typeactivity_speciality_typeofactivity FOREIGN KEY ( typeofactivity_id ) REFERENCES "public".typeofactivity( id )   
 );

CREATE  TABLE "public".agenda ( 
	id                   integer DEFAULT nextval('healthpro_agenda_id_seq'::regclass) NOT NULL  ,
	dayofweek            integer  NOT NULL  ,
	start_time           time  NOT NULL  ,
	end_time             time  NOT NULL  ,
	healthpro_id         integer  NOT NULL  ,
	created_at           timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	status               boolean DEFAULT true   ,
	CONSTRAINT pk_healthpro_agenda PRIMARY KEY ( id ),
	CONSTRAINT fk_healthpro_agenda_healthpro FOREIGN KEY ( healthpro_id ) REFERENCES "public".healthpro( id )   
 );

CREATE  TABLE "public".appointment_avg ( 
	id                   integer DEFAULT nextval('appointment_avg_id_seq'::regclass) NOT NULL  ,
	duration             integer  NOT NULL  ,
	healthpro_id         integer  NOT NULL  ,
	created_at           timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	CONSTRAINT pk_appointment_avg PRIMARY KEY ( id ),
	CONSTRAINT fk_appointment_avg_healthpro FOREIGN KEY ( healthpro_id ) REFERENCES "public".healthpro( id )   
 );

CREATE  TABLE "public".communes ( 
	id                   integer DEFAULT nextval('communes_id_seq'::regclass) NOT NULL  ,
	district_id          integer  NOT NULL  ,
	name                 varchar(100)    ,
	CONSTRAINT pk_communes PRIMARY KEY ( id ),
	CONSTRAINT fk_communes_districts FOREIGN KEY ( district_id ) REFERENCES "public".districts( id )   
 );

CREATE  TABLE "public".event ( 
	id                   integer DEFAULT nextval('event_id_seq'::regclass) NOT NULL  ,
	consultation         varchar(255)    ,
	end_dt               timestamp    ,
	event_type_id        integer  NOT NULL  ,
	reason               varchar(255)    ,
	start_dt             timestamp    ,
	healthpro_id         integer    ,
	patient_id           integer    ,
	user_id              integer    ,
	created_at           timestamp DEFAULT CURRENT_TIMESTAMP   ,
	CONSTRAINT event_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".jwt ( 
	id                   integer DEFAULT nextval('jwt_id_seq'::regclass) NOT NULL  ,
	created_at           timestamp    ,
	expires_at           timestamp    ,
	token                varchar(255)    ,
	user_id              integer    ,
	CONSTRAINT jwt_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".notification ( 
	id                   integer DEFAULT nextval('notification_id_seq'::regclass) NOT NULL  ,
	message              varchar(255)    ,
	user_id              integer  NOT NULL  ,
	"type"               varchar(255)    ,
	created_at           timestamp DEFAULT CURRENT_TIMESTAMP   ,
	seen_at              timestamp    ,
	CONSTRAINT notification_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".otpvalidation ( 
	id                   integer DEFAULT nextval('otpvalidation_id_seq'::regclass) NOT NULL  ,
	user_id              integer    ,
	digit_code           varchar(255)  NOT NULL  ,
	created_at           timestamp  NOT NULL  ,
	expires_at           timestamp  NOT NULL  ,
	"value"              varchar(255)    ,
	CONSTRAINT pk_otpvalidation PRIMARY KEY ( id )
 );

CREATE  TABLE "public".patient ( 
	id                   integer DEFAULT nextval('patient_id_seq'::regclass) NOT NULL  ,
	birthdate            date    ,
	contact              varchar(255)    ,
	firstname            varchar(255)    ,
	gender               boolean  NOT NULL  ,
	identifier           varchar(255)    ,
	name                 varchar(255)    ,
	caretaker_id         integer    ,
	relationship_id      integer    ,
	CONSTRAINT patient_pkey PRIMARY KEY ( id ),
	CONSTRAINT uk_18t7q3f68xnb0h6yd8ulf5x8a UNIQUE ( contact ) ,
	CONSTRAINT uk_r0iljx4mc92nwunjn7a3mruv8 UNIQUE ( identifier ) 
 );

CREATE  TABLE "public".useraccount ( 
	id                   integer DEFAULT nextval('user_id_seq'::regclass) NOT NULL  ,
	email                varchar(255)  NOT NULL  ,
	"password"           varchar(255)  NOT NULL  ,
	role_id              integer    ,
	patient_id           integer    ,
	healthpro_id         integer    ,
	contact              varchar(255)    ,
	company_id           integer    ,
	commune_id           integer    ,
	address              varchar(255)    ,
	created_at           timestamp DEFAULT CURRENT_TIMESTAMP   ,
	profile_picture_url  varchar(255)    ,
	CONSTRAINT pk_tbl PRIMARY KEY ( id ),
	CONSTRAINT unq_useraccount_email UNIQUE ( email ) 
 );

ALTER TABLE "public".event ADD CONSTRAINT fk_event_event_type FOREIGN KEY ( event_type_id ) REFERENCES "public".event_type( id );

ALTER TABLE "public".event ADD CONSTRAINT fk64ldhqy9f5ssspyjlwxtm5lka FOREIGN KEY ( healthpro_id ) REFERENCES "public".healthpro( id );

ALTER TABLE "public".event ADD CONSTRAINT fk3897kfqk5fdqc7sas021r46eo FOREIGN KEY ( patient_id ) REFERENCES "public".patient( id );

ALTER TABLE "public".event ADD CONSTRAINT fkean3cnq7jd2e68kfhioi3oqog FOREIGN KEY ( user_id ) REFERENCES "public".useraccount( id );

ALTER TABLE "public".jwt ADD CONSTRAINT fk_jwt_user FOREIGN KEY ( user_id ) REFERENCES "public".useraccount( id );

ALTER TABLE "public".notification ADD CONSTRAINT fk_notification_useraccount FOREIGN KEY ( user_id ) REFERENCES "public".useraccount( id );

ALTER TABLE "public".otpvalidation ADD CONSTRAINT fk_otpvalidation_user FOREIGN KEY ( user_id ) REFERENCES "public".useraccount( id );

ALTER TABLE "public".patient ADD CONSTRAINT fkidpodojkysthau5k66yejf8b FOREIGN KEY ( relationship_id ) REFERENCES "public".relationship( id );

ALTER TABLE "public".patient ADD CONSTRAINT fk_patient_affiliationorder FOREIGN KEY ( caretaker_id ) REFERENCES "public".useraccount( id );

ALTER TABLE "public".useraccount ADD CONSTRAINT fk_useraccount_communes FOREIGN KEY ( commune_id ) REFERENCES "public".communes( id );

ALTER TABLE "public".useraccount ADD CONSTRAINT fk_user_company FOREIGN KEY ( company_id ) REFERENCES "public".company( id );

ALTER TABLE "public".useraccount ADD CONSTRAINT fk_user_healthpro FOREIGN KEY ( healthpro_id ) REFERENCES "public".healthpro( id );

ALTER TABLE "public".useraccount ADD CONSTRAINT fk_user FOREIGN KEY ( patient_id ) REFERENCES "public".patient( id );

ALTER TABLE "public".useraccount ADD CONSTRAINT fk_user_roles FOREIGN KEY ( role_id ) REFERENCES "public"."role"( id );

CREATE OR REPLACE FUNCTION public.filterunaivalability(agddtos agendadto[], healthproid integer)
 RETURNS agendadto[]
 LANGUAGE plpgsql
AS $function$    
   DECLARE        
    agddtosfiltered agendadto [] := ARRAY[]::agendadto[]  ;
    agddto agendadto;
    agd_start timestamp;
    agd_end timestamp;
   BEGIN
                  FOREACH agddto IN ARRAY agddtos
                  LOOP
                    agd_start :=  agddto._start + INTERVAL '1 second';
                    agd_end := agddto._end - INTERVAL '1 second';                                       
		                   IF NOT EXISTS (Select 1 from event where  healthpro_id=healthproid 
            and event_type_id<>(select id from event_type where name='Cancelled_by_patient')
            and (
                  (agd_start between start_dt and end_dt)
             or
                  (agd_end  between start_dt and end_dt)
                  or (
                         (start_dt between agd_start and agd_end ) and (end_dt between agd_start and agd_end)
                     )
            )) THEN
                           
                                agddtosfiltered  := agddtosfiltered || agddto;  
                            END IF;
                  END LOOP;
      return agddtosfiltered;
 END;
   $function$
;

CREATE OR REPLACE FUNCTION public.getagendadto(currdate date, enddate date, healthproid integer)
 RETURNS agendadto[]
 LANGUAGE plpgsql
AS $function$
   DECLARE
    agddtos agendadto[] := ARRAY[]::agendadto[]  ;
    agds agenda[];
    agd agenda;
    step_date date;
    day_of_week int;
    app_avg int;
   BEGIN
	    step_date:=currdate;
	     WHILE step_date <= enddate LOOP
		         SELECT COALESCE((select duration from appointment_avg where  healthpro_id=healthproid  
                                                    and created_at::date <= step_date order by created_at  DESC limit 1),30) as duration into app_avg;
                select EXTRACT(DOW from step_date)+1  into day_of_week;
		        select ARRAY( select ROW(id,dayofweek,start_time,end_time,healthpro_id,created_at,status)
                         from agenda where healthpro_id=healthproid and dayofweek=day_of_week) into agds;
                  FOREACH agd IN ARRAY agds
                  LOOP
		                  agddtos:= agddtos ||  splitintoagendadto(agd,step_date,app_avg)::agendadto[];
                  END LOOP;
                 step_date:= step_date + (1 || ' day')::interval;
        END LOOP;
            agddtos:=filterunaivalability(agddtos,healthproid);
    return agddtos;
 END;
   $function$
;

CREATE OR REPLACE FUNCTION public.gethealthproidentifier()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
   DECLARE
    next_seq INT;
    identifier_prefix TEXT;
    result_value TEXT;
   BEGIN
-- get next identifier
    SELECT nextval('healthpro_identifier_seq') INTO next_seq;
    
    IF company_id is not null then
       
         SELECT identfier into identifier_prefix from typeofactivity where id=(select  typeofactivity_id from company where id=company_id);   
 
     ELSE
        
        SELECT identifier INTO identifier_prefix FROM typeofactivity where id=NEW.typeofactivity;
  
     END IF;
   
    NEW.identifier := identifier_prefix || next_seq;
   
    RETURN NEW;
   END;
   $function$
;

CREATE OR REPLACE FUNCTION public.getpatientidentifier()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
   DECLARE
    gender_description TEXT;
    next_identifier INT;
    result_value TEXT;
   BEGIN
-- get next identifier
    SELECT nextval('patient_identifier_seq') INTO next_identifier;
    IF NEW.gender = true THEN
        result_value := 'XY-' || next_identifier;
    ELSE
        result_value := 'XX-' || next_identifier;
    END IF;
    NEW.identifier := result_value;
   RETURN NEW;
   END;
   $function$
;

CREATE OR REPLACE FUNCTION public.notifyaddagenda(h_id integer, postponed_id integer, created_at timestamp without time zone)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$    
 DECLARE
    rec record;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN        
       for rec in SELECT id,patient_id,healthpro_id,user_id,start_dt from event WHERE healthpro_id=h_id  and
              event_type_id=postponed_id  and event.created_at>=created_at
        loop    
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:=' Votre rendez-vous le  '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au nom de '|| p_name || '  avec  ' || h_name  || '  est reporté ';
                insert into notification(message,user_id,created_at) values(message,rec.user_id,created_at);
        end loop;
        return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.notifyannulation(event_id integer, user_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$    
 DECLARE
    rec record;
    event_type_id integer;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN  
       for rec in (SELECT id,patient_id,healthpro_id,event.user_id,start_dt from event WHERE id=event_id)
        loop    
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:=' Votre rendez-vous le  '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au nom de '|| p_name;
                if user_id=rec.user_id then
                     message:= message ||'  avec  ' || h_name  ;
                end if;
                message:= message  || '  est annulé ';
                insert into notification(message,user_id) values(message,user_id);
        end loop;
    return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.notifyappointment(event_id integer, user_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$        
 DECLARE    
    rec record;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN
       for rec in SELECT id,patient_id,healthpro_id,event.user_id,start_dt from event WHERE id=event_id  
        loop        
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:='Vous avez un nouveau  rendez-vous le   '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au  nom de  '|| p_name ;
                insert into notification(message,user_id) values(message,user_id);
        end loop;
    return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.notifymissed(event_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$        
 DECLARE    
    rec record;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN
       for rec in SELECT id,patient_id,healthpro_id,event.user_id,start_dt from event WHERE id=event_id  
        loop        
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:='Vous avez manqué le  rendez-vous du   '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au nom de '|| p_name || '  avec  ' || h_name;
                insert into notification(message,user_id) values(message,rec.user_id);
        end loop;
    return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.notifyreport(h_id integer, _start timestamp without time zone, _end timestamp without time zone, postponed_id integer, created_at timestamp without time zone)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$    
 DECLARE
    rec record;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN
       for rec in SELECT id,patient_id,healthpro_id,user_id,start_dt from event WHERE healthpro_id=h_id  and
             (start_dt between _start and _end or end_dt between _start  and _end)
             and event_type_id=postponed_id
        loop    
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:=' Votre rendez-vous le  '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au nom de '|| p_name || '  avec  ' || h_name  || '  est reporté ';
                insert into notification(message,user_id,created_at) values(message,rec.user_id,created_at);
        end loop;
        return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.notifyreportagenda(h_id integer, _start time without time zone, _end time without time zone, postponed_id integer, created_at timestamp without time zone)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$    
 DECLARE
    rec record;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN        
       for rec in SELECT id,patient_id,healthpro_id,user_id,start_dt from event WHERE healthpro_id=h_id  and
             (CAST(start_dt as time) between _start and  _end or CAST(end_dt as time) between _start  and _end)
             and event_type_id=postponed_id and event.created_at>=created_at
        loop    
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:=' Votre rendez-vous le  '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au nom de '|| p_name || '  avec  ' || h_name  || '  est reporté ';
                insert into notification(message,user_id,created_at) values(message,rec.user_id,created_at);
        end loop;
        return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.notifyresultat(event_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$        
 DECLARE
    rec record;
    p_name varchar(255);
    h_name varchar(255);
    message varchar(255);
 BEGIN
       for rec in SELECT id,patient_id,healthpro_id,user_id,start_dt from event WHERE id=event_id  
        loop    
               select name||'  '||firstname into p_name from patient where id=rec.patient_id;
                select name||'  '||first_name into h_name from healthpro where id=rec.healthpro_id;
                SET LC_TIME = 'fr_FR.utf8';
                message:='Le résultat  de votre consultation le  '|| to_char(rec.start_dt, 'TMDay DD TMMonth  YYYY HH24:MI') ;
                message:= message || ' au nom de '|| p_name || '  avec  ' || h_name || ' est disponible ' ;
                insert into notification(message,user_id) values(message,rec.user_id);
        end loop;
        return 1;
 END;
 $function$
;

CREATE OR REPLACE FUNCTION public.splitintoagendadto(agd agenda, currdate date, app_avg integer)
 RETURNS agendadto[]
 LANGUAGE plpgsql
AS $function$
   DECLARE
    agddtos agendadto[] := ARRAY[]::agendadto[]  ;
    start_time time;
    end_time time;
    step_time time;
    agddto agendadto;   
   BEGIN    
       start_time:=agd.start_time;  
       step_time := start_time + (app_avg || ' minutes')::interval;
       end_time:=agd.end_time;
        WHILE step_time <= end_time LOOP  
               if currdate+start_time >=now()+ INTERVAL '30 minutes' then
                       select  
                            currdate +start_time,
                            currdate+step_time
                       into agddto;
                       agddtos:= agddtos || Array[agddto]::agendadto[]; 
                end if;
               step_time := step_time + (app_avg || ' minutes')::interval;
               start_time := start_time + (app_avg || ' minutes')::interval;
        END LOOP;
      return agddtos;
 END;
   $function$
;

CREATE VIEW "public".v_addresse AS  SELECT p.id AS p_id,
    p.name AS p_name,
    r.id AS r_id,
    r.name AS r_name,
    d.id AS d_id,
    d.name AS d_name,
    c.id AS c_id,
    c.name AS c_name
   FROM (((provinces p
     JOIN regions r ON ((r.province_id = p.id)))
     JOIN districts d ON ((d.region_id = r.id)))
     JOIN communes c ON ((c.district_id = d.id)));

CREATE VIEW "public".v_healthpro_addresse AS  SELECT h.id,
    h.name,
    h.first_name,
    v_ad.p_name AS province,
    v_ad.r_name AS region,
    v_ad.d_name AS district,
    v_ad.c_name AS commune,
    s.description AS sepcialite
   FROM (((healthpro h
     JOIN company c ON ((h.company_id = c.id)))
     JOIN v_addresse v_ad ON ((v_ad.c_id = c.id)))
     JOIN speciality s ON ((h.speciality_id = s.id)));

CREATE VIEW "public".v_pointage_healthpro AS  SELECT u.id AS user_id,
    row_number() OVER () AS id,
    COALESCE(e.appointment, (0)::bigint) AS appointment,
    COALESCE(e.made, (0)::bigint) AS made,
    COALESCE(e.missed, (0)::bigint) AS missed,
    COALESCE(e.cancelled_by_hpro, (0)::bigint) AS cancelled_by_hpro,
    COALESCE(e.cancelled_by_patient, (0)::bigint) AS cancelled_by_patient,
    COALESCE(e.postponed, (0)::bigint) AS postponed,
    COALESCE(e.feed_back, (0)::bigint) AS feed_back,
    COALESCE((((((e.appointment + e.made) + e.missed) + e.cancelled_by_hpro) + e.postponed) + e.feed_back), (0)::bigint) AS total
   FROM (useraccount u
     LEFT JOIN ( SELECT event.healthpro_id,
            row_number() OVER () AS id,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'appointment'::text))) THEN 1
                    ELSE NULL::integer
                END) AS appointment,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'made'::text))) THEN 1
                    ELSE NULL::integer
                END) AS made,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'missed'::text))) THEN 1
                    ELSE NULL::integer
                END) AS missed,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'Cancelled_by_Healthpro'::text))) THEN 1
                    ELSE NULL::integer
                END) AS cancelled_by_hpro,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'Cancelled_by_patient'::text))) THEN 1
                    ELSE NULL::integer
                END) AS cancelled_by_patient,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'postponed'::text))) THEN 1
                    ELSE NULL::integer
                END) AS postponed,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'Need_Feedback'::text))) THEN 1
                    ELSE NULL::integer
                END) AS feed_back
           FROM event
          GROUP BY event.healthpro_id) e ON ((u.healthpro_id = e.healthpro_id)))
  WHERE (u.healthpro_id IS NOT NULL);

CREATE VIEW "public".v_pointage_patient AS  SELECT u.id AS user_id,
    row_number() OVER () AS id,
    COALESCE(e.appointment, (0)::bigint) AS appointment,
    COALESCE(e.made, (0)::bigint) AS made,
    COALESCE(e.missed, (0)::bigint) AS missed,
    COALESCE(e.cancelled_by_hpro, (0)::bigint) AS cancelled_by_hpro,
    COALESCE(e.cancelled_by_patient, (0)::bigint) AS cancelled_by_patient,
    COALESCE(e.postponed, (0)::bigint) AS postponed,
    COALESCE(e.feed_back, (0)::bigint) AS feed_back,
    COALESCE((((((e.appointment + e.made) + e.missed) + e.cancelled_by_patient) + e.postponed) + e.feed_back), (0)::bigint) AS total
   FROM (useraccount u
     LEFT JOIN ( SELECT event.user_id,
            row_number() OVER () AS id,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'appointment'::text))) THEN 1
                    ELSE NULL::integer
                END) AS appointment,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'made'::text))) THEN 1
                    ELSE NULL::integer
                END) AS made,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'missed'::text))) THEN 1
                    ELSE NULL::integer
                END) AS missed,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'Cancelled_by_Healthpro'::text))) THEN 1
                    ELSE NULL::integer
                END) AS cancelled_by_hpro,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'Cancelled_by_patient'::text))) THEN 1
                    ELSE NULL::integer
                END) AS cancelled_by_patient,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'postponed'::text))) THEN 1
                    ELSE NULL::integer
                END) AS postponed,
            count(
                CASE
                    WHEN (event.event_type_id = ( SELECT event_type.id
                       FROM event_type
                      WHERE ((event_type.name)::text = 'Need_Feedback'::text))) THEN 1
                    ELSE NULL::integer
                END) AS feed_back
           FROM event
          GROUP BY event.user_id) e ON ((u.id = e.user_id)))
  WHERE (u.patient_id IS NOT NULL);

CREATE MATERIALIZED VIEW "public".v_localisation AS  SELECT p.id AS province_id,
    p.name AS province_name,
    r.id AS region_id,
    r.name AS region_name,
    d.id AS district_id,
    d.name AS district_name,
    c.id AS commune_id,
    c.name AS commune_name
   FROM (((provinces p
     JOIN regions r ON ((p.id = r.province_id)))
     JOIN districts d ON ((r.id = d.region_id)))
     JOIN communes c ON ((d.id = c.district_id)));

CREATE TRIGGER healthproidentifiertrigger BEFORE INSERT ON public.healthpro FOR EACH ROW EXECUTE FUNCTION gethealthproidentifier();

CREATE TRIGGER patientidentifiertrigger BEFORE INSERT ON public.patient FOR EACH ROW EXECUTE FUNCTION getpatientidentifier();

INSERT INTO "public".affiliationorder( id, description ) VALUES ( 1, 'Ordre des masseurs kinésithérapeutes');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 2, 'Ordre des sages femmes');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 3, 'ORDRE NATIONAL DES CHIRURGIENS-DENTISTES');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 4, 'ORDRE NATIONAL DES INFIRMIERS');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 5, 'Ordre national des médecins');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 6, 'ORDRE NATIONAL DES PÉDICURES-PODOLOGUES');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 7, 'ORDRE NATIONAL DES PHARMACIENS');
INSERT INTO "public".affiliationorder( id, description ) VALUES ( 8, 'Ordre national des psychologues');
INSERT INTO "public".civility( id, description ) VALUES ( 1, 'Doctor');
INSERT INTO "public".civility( id, description ) VALUES ( 2, 'Professor');
INSERT INTO "public".civility( id, description ) VALUES ( 3, 'Mr.');
INSERT INTO "public".civility( id, description ) VALUES ( 4, 'Mr.');
INSERT INTO "public".civility( id, description ) VALUES ( 5, 'Mrs.');
INSERT INTO "public".civility( id, description ) VALUES ( 6, 'Dr.');
INSERT INTO "public".event_type( id, name ) VALUES ( 1, 'appointment');
INSERT INTO "public".event_type( id, name ) VALUES ( 2, 'unavailability');
INSERT INTO "public".event_type( id, name ) VALUES ( 3, 'postponed');
INSERT INTO "public".event_type( id, name ) VALUES ( 5, 'made');
INSERT INTO "public".event_type( id, name ) VALUES ( 6, 'missed');
INSERT INTO "public".event_type( id, name ) VALUES ( 4, 'Cancelled_by_patient');
INSERT INTO "public".event_type( id, name ) VALUES ( 7, 'Cancelled_by_healthpro');
INSERT INTO "public".event_type( id, name ) VALUES ( 8, 'Need_feedback');
INSERT INTO "public".medicament( id, name ) VALUES ( 20, '"s"');
INSERT INTO "public".medicament( id, name ) VALUES ( 21, '"paracetamol"');
INSERT INTO "public".medicament( id, name ) VALUES ( 22, '{"name":"paracetamols"}');
INSERT INTO "public".medicament( id, name ) VALUES ( 23, '"{name = \"zzzz\"}"');
INSERT INTO "public".medicament( id, name ) VALUES ( 24, '"{name : \"zzzsqz\"}"');
INSERT INTO "public".medicament( id, name ) VALUES ( 25, '{name : "zzzsqz"}');
INSERT INTO "public".medicament( id, name ) VALUES ( 26, '{"name"  : "value",  }');
INSERT INTO "public".medicament( id, name ) VALUES ( 27, 'paracetamols');
INSERT INTO "public".medicament( id, name ) VALUES ( 30, 'szaa');
INSERT INTO "public".medicament( id, name ) VALUES ( 31, 'sqd');
INSERT INTO "public".medicament( id, name ) VALUES ( 33, 'dsqdsqd');
INSERT INTO "public".medicament( id, name ) VALUES ( 34, 'paracetamol');
INSERT INTO "public".medicament_type( id, name ) VALUES ( 1, 'comprime');
INSERT INTO "public".provinces( id, name ) VALUES ( 1, 'Antananarivo');
INSERT INTO "public".provinces( id, name ) VALUES ( 2, 'Antsiranana');
INSERT INTO "public".provinces( id, name ) VALUES ( 3, 'Fianarantsoa');
INSERT INTO "public".provinces( id, name ) VALUES ( 4, 'Mahajanga');
INSERT INTO "public".provinces( id, name ) VALUES ( 5, 'Toamasina');
INSERT INTO "public".provinces( id, name ) VALUES ( 6, 'Toliara');
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 1, 'Itasy', 1);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 2, 'Analamanga', 1);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 3, 'Vakinankaratra', 1);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 4, 'Bongolava', 1);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 5, 'SAVA', 2);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 6, 'DIANA', 2);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 7, 'Amoron''i Mania', 3);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 8, 'Haute Matsiatra', 3);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 9, 'Vatovavy-Fitovinany', 3);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 10, 'Atsimo-Atsinanana', 3);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 11, 'Ihorombe', 3);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 12, 'Sofia', 4);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 13, 'Boeny', 4);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 14, 'Betsiboka', 4);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 15, 'Melaky', 4);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 16, 'Alaotra-Mangoro', 5);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 17, 'Atsinanana', 5);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 18, 'Analanjirofo', 5);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 19, 'Menabe', 6);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 20, 'Atsimo-Andrefana', 6);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 21, 'Androy', 6);
INSERT INTO "public".regions( id, name, province_id ) VALUES ( 22, 'Anosy', 6);
INSERT INTO "public".relationship( id, name ) VALUES ( 2, 'sibling');
INSERT INTO "public".relationship( id, name ) VALUES ( 3, 'parent');
INSERT INTO "public".relationship( id, name ) VALUES ( 4, 'Frère');
INSERT INTO "public".relationship( id, name ) VALUES ( 5, 'Soeur');
INSERT INTO "public".relationship( id, name ) VALUES ( 6, 'Cousin');
INSERT INTO "public".relationship( id, name ) VALUES ( 7, 'Cousine');
INSERT INTO "public".relationship( id, name ) VALUES ( 8, 'Père');
INSERT INTO "public".relationship( id, name ) VALUES ( 9, 'Mère');
INSERT INTO "public".relationship( id, name ) VALUES ( 10, 'Autres');
INSERT INTO "public"."role"( id, name ) VALUES ( 1, 'admin');
INSERT INTO "public"."role"( id, name ) VALUES ( 2, 'patient');
INSERT INTO "public"."role"( id, name ) VALUES ( 3, 'healthpro');
INSERT INTO "public"."role"( id, name ) VALUES ( 4, 'secretary');
INSERT INTO "public"."role"( id, name ) VALUES ( 5, 'admin');
INSERT INTO "public".speciality( id, description ) VALUES ( 26, 'gyneco');
INSERT INTO "public".speciality( id, description ) VALUES ( 27, 'Vlad');
INSERT INTO "public".speciality( id, description ) VALUES ( 28, 'Common');
INSERT INTO "public".speciality( id, description ) VALUES ( 29, 'Common');
INSERT INTO "public".speciality( id, description ) VALUES ( 30, 'Cardiologue');
INSERT INTO "public".speciality( id, description ) VALUES ( 31, 'Dermatologue');
INSERT INTO "public".speciality( id, description ) VALUES ( 32, 'Pédiatre');
INSERT INTO "public".speciality( id, description ) VALUES ( 33, 'Gynécologue');
INSERT INTO "public".speciality( id, description ) VALUES ( 34, 'Médecin Généraliste');
INSERT INTO "public".symptom( id, name ) VALUES ( 1, 'fievre');
INSERT INTO "public".symptom( id, name ) VALUES ( 2, 'sqdqsd');
INSERT INTO "public".symptom( id, name ) VALUES ( 3, 'manavy');
INSERT INTO "public".typeofactivity( id, description, max_account_permitted, identifier ) VALUES ( 1, 'Médecin libéral', 1, 'ML');
INSERT INTO "public".typeofactivity( id, description, max_account_permitted, identifier ) VALUES ( 2, 'Tradipraticien', 4, 'TDP');
INSERT INTO "public".typeofactivity( id, description, max_account_permitted, identifier ) VALUES ( 3, 'Cabinet médical', 1, 'CM');
INSERT INTO "public".typeofactivity( id, description, max_account_permitted, identifier ) VALUES ( 4, 'Établissement de santé', 4, 'ES');
INSERT INTO "public".typeofactivity( id, description, max_account_permitted, identifier ) VALUES ( 5, 'Centre d’analyse', 4, 'CA');
INSERT INTO "public".typeofactivity( id, description, max_account_permitted, identifier ) VALUES ( 6, 'Centre d’imagerie', 4, 'CI');
INSERT INTO "public".company( id, name, nif, stat, typeofactivity_id, picture, socialreason, creationdate, images, address ) VALUES ( 44, 'Meddoc', 'sqdsqd', 'qsdsq', 1, null, 'dqsdqsd', null, null, null);
INSERT INTO "public".company( id, name, nif, stat, typeofactivity_id, picture, socialreason, creationdate, images, address ) VALUES ( 45, 'meddoc', 'ss', 'ssss', 1, 'ok.jpg', 'ssss', '2023-11-02', null, null);
INSERT INTO "public".company( id, name, nif, stat, typeofactivity_id, picture, socialreason, creationdate, images, address ) VALUES ( 46, 'sqdqs', 'dqsdqsd', 'sqdsqdqsdqs', 1, 'ok.jpg', 'sqdsqd', '2023-11-23', null, null);
INSERT INTO "public".company( id, name, nif, stat, typeofactivity_id, picture, socialreason, creationdate, images, address ) VALUES ( 47, 'sdsqdqsdqs', 'qdqsdqsd', 'sdqsdsq', 2, 'ok.jpg', 'qsdqdqsd', '2023-11-15', null, null);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 1, 'Arivonimamo', 1);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 2, 'Miarinarivo', 1);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 3, 'Soavinandriana', 1);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 4, 'Ambohidratrimo', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 5, 'Andramasina', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 6, 'Anjozorobe', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 7, 'Ankazobe', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 8, 'Antananarivo-Atsimondrano', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 9, 'Antananarivo-Avaradrano', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 10, 'Antananarivo-Renivohitra', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 11, 'Manjakandriana', 2);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 13, 'Ambatolampy', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 14, 'Antanifotsy', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 15, 'Antsirabe-I', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 16, 'Antsirabe-II', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 17, 'Betafo', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 18, 'Faratsiho', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 19, 'Mandoto', 3);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 20, 'Fenoarivobe', 4);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 21, 'Tsiroanomandidy', 4);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 22, 'Andapa', 5);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 23, 'Antalaha', 5);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 24, 'Sambava', 5);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 25, 'Vohemar', 5);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 27, 'Antsiranana-I', 6);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 28, 'Antsiranana-II', 6);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 29, 'Ambilobe', 6);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 30, 'Ambanja', 6);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 31, 'Nosy-Be', 6);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 32, 'Ambatofinandrahana', 7);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 33, 'Ambositra', 7);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 34, 'Fandriana', 7);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 35, 'Manandriana', 7);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 36, 'Ambalavao', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 37, 'Ambohimahasoa', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 38, 'Fianarantsoa', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 39, 'Ikalamavony', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 40, 'Isandra', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 41, 'Lalangina', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 42, 'Vohibato', 8);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 43, 'Ifanadiana', 9);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 44, 'Ikongo', 9);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 45, 'Manakara', 9);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 46, 'Mananjary', 9);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 47, 'Nosy-Varika', 9);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 48, 'Vohipeno', 9);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 49, 'Befotaka', 10);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 50, 'Farafangana', 10);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 51, 'Midongy', 10);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 52, 'Vangaindrano', 10);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 53, 'Vondrozo', 10);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 54, 'Iakora', 11);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 55, 'Ihosy', 11);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 56, 'Ivohibe', 11);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 57, 'Analalava', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 58, 'Antsohihy', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 59, 'Bealanana', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 60, 'Befandriana-Avaratra', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 61, 'Boriziny', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 62, 'Mampikony', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 63, 'Mandritsara', 12);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 64, 'Ambato-Boeny', 13);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 65, 'Mahajanga-I', 13);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 66, 'Mahajanga-II', 13);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 67, 'Marovoay', 13);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 68, 'Mitsinjo', 13);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 69, 'Soalala', 13);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 70, 'Kandreho', 14);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 71, 'Maevatanana', 14);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 72, 'Tsaratanana', 14);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 73, 'Ambatomainty', 15);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 74, 'Antsalova', 15);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 75, 'Besalampy', 15);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 76, 'Maintirano', 15);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 77, 'Morafenobe', 15);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 78, 'Ambatondrazaka', 16);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 79, 'Amparafaravola', 16);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 80, 'Andilamena', 16);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 81, 'Anosibe-An''ala', 16);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 82, 'Moramanga', 16);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 83, 'Antanambao-Manampotsy', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 84, 'Brickaville', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 85, 'Mahanoro', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 86, 'Marolambo', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 87, 'Tamatave-I', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 88, 'Tamatave-II', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 89, 'Vatomandry', 17);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 90, 'Fénérive-Est', 18);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 91, 'Manarana-Nord', 18);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 92, 'Maroantsetra', 18);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 93, 'Nosy-Boraha', 18);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 94, 'Soanierana-Ivongo', 18);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 95, 'Vavatenina', 18);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 96, 'Belo-sur-Tsiribihina', 19);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 97, 'Mahabo', 19);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 98, 'Manja', 19);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 99, 'Miandrivazo', 19);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 100, 'Morondava', 19);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 101, 'Ampanihy', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 102, 'Ankazoabo', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 103, 'Benenitra', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 104, 'Betioky-Sud', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 105, 'Beroroha', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 106, 'Morombe', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 107, 'Sakaraha', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 108, 'Tuléar-I', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 109, 'Tuléar-II', 20);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 110, 'Ambovombe', 21);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 111, 'Bekily', 21);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 112, 'Beloha', 21);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 113, 'Tsiombe', 21);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 114, 'Amboasary-Sud', 22);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 115, 'Betroka', 22);
INSERT INTO "public".districts( id, name, region_id ) VALUES ( 116, 'Taolanaro', 22);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 96, 'sqdsqd', 'ML76', null, 'dqsdsqdqs', 26, 47, null, 'dqsdsqd', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 99, 'sqdsqd', 'ML79', null, 'dqsdsqdqs', 26, 47, null, 'dqsdsqd', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 100, 'sqdsqd', 'ML80', null, 'dqsdsqdqs', 26, 47, null, 'dqsdsqd', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 101, 'sqdsqd', 'ML81', null, 'dqsdsqdqs', 26, 47, null, 'dqsdsqd', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 104, 'admin', 'ML84', null, 'admin', 26, null, null, 'admin', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 87, 'Jean', 'ML67', null, '15092022', 30, null, null, 'Luis', null, null, '{"tarifs":[{"description":"Échocardiographie","prix":"150000 ar"},{"description":"Holter (Monitorage ambulatoire ECG)","prix":"200000 ar"}],"Experiences":[{"poste":"Cardiologue","entreprise":"Centre Médical Cardiaque de Madagascar","dateDebut":"Janvier 2022","dateFin":"Juillet 2023","description":" Fournir des soins spécialisés et de contribuer à la prise en charge des patients atteints de maladies cardiaques"}],"diplome":[{"anne_diplome":"2015","lieu_diplome":"Ankatso Antananarivo","diplome":"Doctorat d''université"}],"images":null,"keywords":[]}');
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 90, 'ko', 'ML70', null, 'dqsdqsd', 26, 46, null, 'ko', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 88, 'Paul', 'ML68', null, '20180612', 34, null, null, 'Maurice', null, null, '{"tarifs":[{"description":"Consultation Générale","prix":"10000 ar"}],"Experiences":[{"poste":"Médecin Généraliste","entreprise":" Centre Médical d''Antananarivo","dateDebut":"Janvier 2017","dateFin":"Juin 2018","description":"Diagnostic et traitement des patients, coordination des soins avec d''autres professionnels de la santé."},{"poste":" Médecin du Travail","entreprise":"Hôpital Tambohobe","dateDebut":"Décembre 2013","dateFin":"Février 2014","description":" Examens médicaux liés au travail, promotion de la santé en milieu professionnel."}],"diplome":[{"anne_diplome":"2017","lieu_diplome":"Genève","diplome":"Diplômes des disciplines de santé"},{"anne_diplome":"2005","lieu_diplome":"Ankatso Antananarivo","diplome":" Doctorat d''université"}],"images":null,"keywords":["médecin","géneral","SoinsPrimaires","Prévention","Examen"]}');
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 112, 'Razafy', 'ML92', null, '1234', 34, null, null, 'Mahefa', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 113, 'Razaka', 'ML93', null, '03030303', 32, null, null, 'Arisoa', null, null, null);
INSERT INTO "public".healthpro( id, name, identifier, affiliation_order_id, order_num, speciality_id, company_id, birth_date, first_name, civility, typeofactivity_id, description ) VALUES ( 106, 'Velo', 'ML86', null, '1815200', 32, null, '1968-12-06 12:00:00 AM', 'Manana', null, null, '{"tarifs":[{"description":"Consultation spécialisée","prix":"12000 ar"},{"description":"Vaccinations ","prix":"10000 ar"}],"Experiences":[{"poste":"Médecin Pédiatre","entreprise":"OSTIE","dateDebut":"Janvier 2019","dateFin":"Février 2023","description":"Fournir des soins médicaux complets et spécialisés aux nourrissons, aux enfants et aux adolescents."}],"diplome":[{"anne_diplome":"2019","lieu_diplome":"Université de Fianarantsoa","diplome":"Doctorat d''université"}],"images":null,"keywords":["SoinsPrimaires","Prévention"]}');
INSERT INTO "public".typeactivity_speciality( typeofactivity_id, speciality_id ) VALUES ( 1, 26);
INSERT INTO "public".typeactivity_speciality( typeofactivity_id, speciality_id ) VALUES ( 2, 26);
INSERT INTO "public".typeactivity_speciality( typeofactivity_id, speciality_id ) VALUES ( 2, 26);
INSERT INTO "public".typeactivity_speciality( typeofactivity_id, speciality_id ) VALUES ( 3, 27);
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 405, 7, '15:55:00', '17:55:00', 88, '2023-11-06 01:51:18 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 406, 1, '15:55:00', '17:55:00', 88, '2023-11-06 01:51:18 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 407, 2, '01:57:00', '08:57:00', 88, '2023-11-06 01:52:02 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 408, 3, '01:57:00', '08:57:00', 88, '2023-11-06 01:52:02 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 411, 5, '14:58:00', '15:58:00', 88, '2023-11-06 01:52:46 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 412, 3, '16:11:00', '18:11:00', 88, '2023-11-06 02:06:20 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 413, 7, '21:12:00', '23:12:00', 88, '2023-11-06 02:07:42 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 414, 1, '21:12:00', '23:12:00', 88, '2023-11-06 02:07:42 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 404, 1, '10:00:00', '11:00:00', 88, '2023-11-06 01:50:06 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 426, 5, '10:00:00', '12:00:00', 88, '2023-11-16 11:01:21 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 434, 1, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 435, 2, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 436, 3, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 437, 4, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 438, 5, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 439, 6, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 440, 7, '07:00:00', '18:12:00', 87, '2023-11-17 09:08:39 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 443, 3, '14:13:00', '14:18:00', 113, '2023-11-21 02:07:06 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 444, 4, '14:13:00', '14:18:00', 113, '2023-11-21 02:07:06 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 442, 2, '14:13:00', '14:52:00', 113, '2023-11-21 02:07:06 PM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 445, 6, '12:00:00', '15:00:00', 88, '2023-11-23 09:50:32 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 446, 7, '12:00:00', '15:00:00', 88, '2023-11-23 09:50:32 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 447, 1, '12:00:00', '15:00:00', 88, '2023-11-23 09:50:32 AM', 't');
INSERT INTO "public".agenda( id, dayofweek, start_time, end_time, healthpro_id, created_at, status ) VALUES ( 448, 4, '06:04:00', '23:04:00', 88, '2023-12-06 06:04:22 PM', 't');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 43, 30, 87, '2023-11-07 02:55:59 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 44, 30, 87, '2023-11-07 03:12:10 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 45, 31, 87, '2023-11-07 03:43:12 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 46, 15, 87, '2023-11-08 09:54:04 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 47, 16, 87, '2023-11-08 09:54:28 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 48, 17, 87, '2023-11-08 09:54:36 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 49, 18, 87, '2023-11-08 09:57:37 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 50, 19, 87, '2023-11-08 10:00:19 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 51, 14, 87, '2023-11-08 10:02:06 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 52, 28, 87, '2023-11-08 10:03:43 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 53, 40, 87, '2023-11-08 10:06:23 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 54, 35, 87, '2023-11-08 10:11:08 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 55, 31, 87, '2023-11-08 10:15:07 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 56, 31, 88, '2023-11-08 10:20:54 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 57, 32, 88, '2023-11-10 11:25:16 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 58, 33, 88, '2023-11-10 11:26:08 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 59, 40, 87, '2023-11-17 09:11:19 AM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 60, 50, 112, '2023-11-17 08:12:26 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 61, 30, 87, '2023-11-17 08:13:41 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 62, 40, 112, '2023-11-17 08:23:31 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 63, 1, 112, '2023-11-17 08:23:45 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 64, 5, 112, '2023-11-17 08:26:29 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 65, 6, 112, '2023-11-17 08:54:08 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 66, 7, 112, '2023-11-17 08:54:43 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 67, 6, 113, '2023-11-10 02:06:33 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 68, 40, 88, '2023-12-06 06:05:27 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 69, 30, 88, '2023-12-06 06:12:32 PM');
INSERT INTO "public".appointment_avg( id, duration, healthpro_id, created_at ) VALUES ( 70, 31, 88, '2023-12-06 06:22:54 PM');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1, 1, 'Alakamisikely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 2, 1, 'Ambatomanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 3, 1, 'Ambatomirahavavy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 4, 1, 'Amboanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 5, 1, 'Ambohimandry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 6, 1, 'Ambohimasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 7, 1, 'Ambohipandrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 8, 1, 'Ambohitrambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 9, 1, 'Ampahimanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 10, 1, 'Andranomiely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 11, 1, 'Antambolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 12, 1, 'Antenimbe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 13, 1, 'Arivonimamo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 14, 1, 'Arivonimamo-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 15, 1, 'Imerintsiatosika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 16, 1, 'Mahatsinjo-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 17, 1, 'Manalalondo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 18, 1, 'Marofangady');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 19, 1, 'Miantsoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 20, 1, 'Morafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 21, 1, 'Morarano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 22, 2, 'Ambatomanjaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 23, 2, 'Analavory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 24, 2, 'Andolofotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 25, 2, 'Anosibe-Ifanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 26, 2, 'Antoby-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 27, 2, 'Manazary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 28, 2, 'Mandiavato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 29, 2, 'Miarinarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 30, 2, 'Miarinarivo-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 31, 2, 'SarobaratraIfanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 32, 2, 'Soamahamanina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 33, 2, 'Soavimbazaha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 34, 2, 'Zoma-Bealoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 35, 3, 'Ambatoasana-Centre');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 36, 3, 'Amberomanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 37, 3, 'Amparaky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 38, 3, 'Ampary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 39, 3, 'Ampefy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 40, 3, 'Ankaranana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 41, 3, 'Ankisabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 42, 3, 'Antanetibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 43, 3, 'Dondona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 44, 3, 'Mahavelona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 45, 3, 'Mananasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 46, 3, 'Masindray');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 47, 3, 'Soavinandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 48, 3, 'Tamponala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 49, 4, 'Ambato(Madagascar)');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 50, 4, 'Ambatolampy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 51, 4, 'Ambohidratrimo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 52, 4, 'Ambohimanjaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 53, 4, 'Ambohipihaonana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 54, 4, 'Ambohitrimanjaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 55, 4, 'Ampangabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 56, 4, 'Ampanotokana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 57, 4, 'Anjanadoria');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 58, 4, 'Anosiala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 59, 4, 'Antanetibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 60, 4, 'Antehiroka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 61, 4, 'Antsahafilo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 62, 4, 'Avaratsena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 63, 4, 'Fiadanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 64, 4, 'Iarinarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 65, 4, 'Ivato(aéroport)');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 66, 4, 'IvatoFiraisana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 67, 4, 'Mahabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 68, 4, 'Mahereza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 69, 4, 'Mahitsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 70, 4, 'Mananjara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 71, 4, 'Manjakavaradrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 72, 4, 'Merimandroso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 73, 4, 'Talatamaty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 74, 5, 'Abohimiadana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 75, 5, 'Alarobia-Vatosola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 76, 5, 'Alatsinainy-Bakaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 77, 5, 'Andohariana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 78, 5, 'Andramasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 79, 5, 'Anosibe-Trimoloharana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 80, 5, 'Fitsinjovana-Bakaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 81, 5, 'Mandrosoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 82, 5, 'Sabotsy-Ambohitromby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 83, 5, 'Sabotsy-Manjakavcahoaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 84, 5, 'Tankafatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 85, 6, 'Alakamisy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 86, 6, 'Ambatomanoina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 87, 6, 'Amboasary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 88, 6, 'Ambohibary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 89, 6, 'Ambongamarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 90, 6, 'Analaroa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 91, 6, 'Anjozorobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 92, 6, 'Antanetibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 93, 6, 'Beronono');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 94, 6, 'Betatao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 95, 6, 'Mangamila');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 96, 6, 'Marotsipoy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 97, 7, 'Ambohitromby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 98, 7, 'Ambolotarakely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 99, 7, 'Ankazobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 100, 7, 'Antakavana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 101, 7, 'Antotohazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 102, 7, 'Fiadanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 103, 7, 'Fihaonana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 104, 7, 'Kiangara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 105, 7, 'Mahavelona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 106, 7, 'Miantso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 107, 7, 'Talata-Angavo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 108, 7, 'Tsaramasoandro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 109, 8, 'Ambalavao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 110, 8, 'Ambatofahavalo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 111, 8, 'Ambohidrapeto');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 112, 8, 'Ambohijanaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 113, 8, 'Ampitatafika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 114, 8, 'Andoharanofotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 115, 8, 'Andranonahoatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 116, 8, 'Androhibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 117, 8, 'Ankaraobato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 118, 8, 'Antanetikely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 119, 8, 'Bemasoandro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 120, 8, 'Bongotsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 121, 8, 'Fenoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 122, 8, 'Itaosy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 123, 8, 'Soalandy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 124, 8, 'Tanjombato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 125, 8, 'Tsiafahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 126, 9, 'Alasora');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 127, 9, 'Ambohimalaza-Miray');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 128, 9, 'Ambohimanambola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 129, 9, 'AmbohimangRova');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 130, 9, 'Ambohimangakely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 131, 9, 'Anjeva-Gara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 132, 9, 'Ankadikely-Ilafy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 133, 9, 'Ankadinandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 134, 9, 'Fieferana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 135, 9, 'Masindray');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 136, 9, 'Sabotsy-Namehana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 137, 9, 'Talatavolonondry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 138, 10, 'Antananarivo-Renivohitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 139, 11, 'Alarobia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 140, 11, 'Ambanitsena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 141, 11, 'Ambatolaona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 142, 11, 'Ambatomanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 143, 11, 'Ambatomena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 144, 11, 'Ambohibary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 145, 11, 'Ambohitrandriamanitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 146, 11, 'Ambohitrolomahitsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 147, 11, 'Ambohitrony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 148, 11, 'Ambohitseheno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 149, 11, 'Anjepy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 150, 11, 'Anjoma-Betoho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 151, 11, 'Ankazondandy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 152, 11, 'Antsahalalina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 153, 11, 'Manjakandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 154, 11, 'Mantasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 155, 11, 'Merimanjaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 156, 11, 'Miadanandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 157, 11, 'Nandihizana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 158, 11, 'Ranovao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 159, 11, 'Sadabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 160, 11, 'Sambaina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 161, 11, 'Soavinandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 162, 13, 'Ambatolampy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 163, 13, 'Ambatondrakalavao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 164, 13, 'Ambodifarihy-Fenomanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 165, 13, 'Ambohipihaonana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 166, 13, 'Andranovelona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 167, 13, 'AndravolaVohipeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 168, 13, 'Andriambilany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 169, 13, 'Antakasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 170, 13, 'Antanamalaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 171, 13, 'Antanimasaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 172, 13, 'Antsampandrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 173, 13, 'Behenjy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 174, 13, 'Belambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 175, 13, 'Manjakatompo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 176, 13, 'Morarano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 177, 13, 'Sabotsy-Namatoana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 178, 13, 'Tsiafajavona-Ankaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 179, 13, 'Tsinjoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 180, 14, 'Ambatolahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 181, 14, 'Ambatomiady');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 182, 14, 'Ambatotsipihina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 183, 14, 'Ambodiriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 184, 14, 'Ambohimandroso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 185, 14, 'Ambohitompoina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 186, 14, 'Ampitatafika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 187, 14, 'Andranofito');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 188, 14, 'Antanifotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 189, 14, 'Antsahalava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 190, 14, 'Antsampandrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 191, 15, 'Antsirabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 192, 16, 'Alakamisy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 193, 16, 'Ambano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 194, 16, 'Ambatomena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 195, 16, 'Ambohibary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 196, 16, 'Ambohidranandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 197, 16, 'Ambohimiarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 198, 16, 'Ambohitsimanova');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 199, 16, 'Andranomanelatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 200, 16, 'Antanambao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 201, 16, 'Antanimandry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 202, 16, 'Antsoatany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 203, 16, 'Belazao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 204, 16, 'Ibity');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 205, 16, 'Manandona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 206, 16, 'Mandrosohasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 207, 16, 'Mangatano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 208, 16, 'Sahanivotry-Mandona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 209, 16, 'Soanindrariny');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 210, 16, 'Tsarahonenana-Sahanivotry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 211, 16, 'Vinaninkarena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 212, 17, 'Alakamisy-Anativato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 213, 17, 'Alakamisy-Marososona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 214, 17, 'AlarobiaBemaha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 215, 17, 'Ambatonikonilahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 216, 17, 'Ambohimanambola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 217, 17, 'Ambohimasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 218, 17, 'Andranomafana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 219, 17, 'Andrembesoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 220, 17, 'Anosiarivo-Manapa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 221, 17, 'Antohobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 222, 17, 'Antsotso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 223, 17, 'Betafo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 224, 17, 'Inanantona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 225, 17, 'Mahaiza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 226, 17, 'Mandritsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 227, 17, 'Manohisoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 228, 17, 'Soavina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 229, 17, 'Tritriva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 230, 18, 'Ambohiborona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 231, 18, 'Andranomiady');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 232, 18, 'Antsapanimahazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 233, 18, 'Faratsiho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 234, 18, 'Miandrarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 235, 18, 'Ramainandro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 236, 18, 'Valabetokana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 237, 18, 'Vinaninony-Atsimo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 238, 18, 'VinaninonyNord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 239, 19, 'AnjomaRamartina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 240, 19, 'Ankazomiriotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 241, 19, 'AntanambaoAmbary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 242, 19, 'Betsohana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 243, 19, 'Fidirana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 244, 19, 'Mandoto');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 245, 19, 'Vasiana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 246, 19, 'Vinany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 247, 20, 'Ambatomainty-Atsimo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 248, 20, 'Ambohitromby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 249, 20, 'Fenoarivobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 250, 20, 'Firavahana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 251, 20, 'Kiranomena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 252, 20, 'Mahajeby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 253, 20, 'Maritampona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 254, 20, 'Tsinjoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 255, 21, 'Ambalanirana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 256, 21, 'Ambararatabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 257, 21, 'Ambatolampy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 258, 21, 'Ankadinondry-Sakay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 259, 21, 'Ankerana-Avaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 260, 21, 'Anosy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 261, 21, 'Belobaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 262, 21, 'Bemahatazana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 263, 21, 'Bevato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 264, 21, 'Fierenana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 265, 21, 'Mahasolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 266, 21, 'Maroharana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 267, 21, 'Miandanarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 268, 21, 'Soanierana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 269, 21, 'Tsinjoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 270, 21, 'Tsiroanomandidy-Fihaonana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 271, 21, 'Tsiroanomandidy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 272, 22, 'Ambalamanasy-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 273, 22, 'Ambodiangezoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 274, 22, 'Ambodimanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 275, 22, 'Andapa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 276, 22, 'Andrakata');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 277, 22, 'Andranomena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 278, 22, 'Anjialava-Be');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 279, 22, 'Ankiaka-Be-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 280, 22, 'Anoviara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 281, 22, 'Antsahamena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 282, 22, 'Bealampona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 283, 22, 'Belaoka-Marovato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 284, 22, 'Betsakotsako-Andranotsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 285, 22, 'Doany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 286, 22, 'Marovato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 287, 22, 'Matsohely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 288, 22, 'Tanandava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 289, 23, 'Ambalabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 290, 23, 'Ambinanifaho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 291, 23, 'Ambohitralanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 292, 23, 'Ampahana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 293, 23, 'Ampohibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 294, 23, 'Antalaha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 295, 23, 'Antananambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 296, 23, 'Antombana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 297, 23, 'Antsahanoro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 298, 23, 'Antsambalahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 299, 23, 'Lanjarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 300, 23, 'Marofinaritra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 301, 23, 'Sarahandrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 302, 23, 'Vinanivao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 303, 24, 'Ambatoafo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 304, 24, 'Amboangibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 305, 24, 'Ambodiampana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 306, 24, 'Ambodivoara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 307, 24, 'Ambohimalaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 308, 24, 'Ambohimitsinjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 309, 24, 'Analamaho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 310, 24, 'Andrahanjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 311, 24, 'Andratamarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 312, 24, 'Anjangoveratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 313, 24, 'Anjialava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 314, 24, 'Anjinjaomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 315, 24, 'Antindra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 316, 24, 'Antsahambaharo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 317, 24, 'Antsahavaribe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 318, 24, 'Bemanevika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 319, 24, 'Bevonotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 320, 24, 'Farahalana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 321, 24, 'Maroambiny');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 322, 24, 'Marogaona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 323, 24, 'Marojala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 324, 24, 'Morafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 325, 24, 'Nosiarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 326, 24, 'Sambava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 327, 24, 'Tanambao-Daoud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 328, 25, 'Ambalasatrana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 329, 25, 'Ambinanin''andravory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 330, 25, 'Amboriala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 331, 25, 'Ampanefena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 332, 25, 'Ampisikina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 333, 25, 'Ampondra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 334, 25, 'Andrafainkona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 335, 25, 'Andravory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 336, 25, 'Antsahavaribe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 337, 25, 'AntsirabeNord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 338, 25, 'Belambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 339, 25, 'Bobakindro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 340, 25, 'Daraina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 341, 25, 'Fanambana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 342, 25, 'Maromokotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 343, 25, 'Milanoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 344, 25, 'Nosibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 345, 25, 'Tsarabaria');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 346, 25, 'Vohemar');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 347, 27, 'Antsiranana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 348, 28, 'Ambondrona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 349, 28, 'Ambolobozobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 350, 28, 'Andrafiabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 351, 28, 'Andranofanjava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 352, 28, 'Andranovondronina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 353, 28, 'Anivorano-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 354, 28, 'Ankarangona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 355, 28, 'Anketrakabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 356, 28, 'Antanamitarana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 357, 28, 'Antsahampano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 358, 28, 'Antsakoabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 359, 28, 'Antsalaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 360, 28, 'Antsoha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 361, 28, 'Bobasakoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 362, 28, 'Bobakilandy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 363, 28, 'Joffreville');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 364, 28, 'Mahalina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 365, 28, 'Mahavanona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 366, 28, 'Mangaoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 367, 28, 'Mosorolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 368, 28, 'Ramena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 369, 28, 'Sadjoavato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 370, 28, 'Sakaramy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 371, 29, 'Ambakirano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 372, 29, 'Ambalan''anjavy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 373, 29, 'Ambarakaraka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 374, 29, 'Ambilobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 375, 29, 'Ambodibonara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 376, 29, 'Ampondralava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 377, 29, 'Anaborano-Ifasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 378, 29, 'Anjiabe-Ambony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 379, 29, 'Antanambe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 380, 29, 'Antsaravibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 381, 29, 'Antsohimbondrona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 382, 29, 'Beramanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 383, 29, 'Betsihaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 384, 29, 'Manambato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 385, 29, 'Mantaly');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 386, 29, 'Sirama-Ankaragna');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 387, 29, 'Tanambao-Marivorahona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 388, 30, 'Ambalahonko');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 389, 30, 'Ambanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 390, 30, 'Ambodimanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 391, 30, 'Ambohimarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 392, 30, 'Ankatafa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 393, 30, 'Ankingameloko');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 394, 30, 'Anorotsangana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 395, 30, 'Antafiambotry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 396, 30, 'Antranokarany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 397, 30, 'Antsahabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 398, 30, 'Antsakoamanondro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 399, 30, 'Antsatsaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 400, 30, 'Antsirabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 401, 30, 'Benavony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 402, 30, 'BemanevikaEst');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 403, 30, 'BemanevikyOuest');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 404, 30, 'Djangoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 405, 30, 'Maevatanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 406, 30, 'Maherivaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 407, 30, 'Marotolana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 408, 30, 'Marovato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 409, 31, 'Nosy-Be');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 410, 32, 'Ambatofinandrahana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 411, 32, 'Ambatomifanongoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 412, 32, 'Ambondromisotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 413, 32, 'Amborompotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 414, 32, 'Fenoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 415, 32, 'Itremo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 416, 32, 'Mandrosonoro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 417, 32, 'Mangataboahangy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 418, 32, 'Soavina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 419, 33, 'Alakamisy-Ambohijato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 420, 33, 'Ambalamanakana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 421, 33, 'Ambatofitorahana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 422, 33, 'Ambinanindrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 423, 33, 'Ambohimitombo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 424, 33, 'Ambositra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 425, 33, 'Ambositra-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 426, 33, 'Andina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 427, 33, 'Ankazoambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 428, 33, 'Antoetra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 429, 33, 'Fahizay-Ambatolahimasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 430, 33, 'Ihadilanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 431, 33, 'Ilaka-Centre');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 432, 33, 'Imerina-Imady');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 433, 33, 'Ivato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 434, 33, 'Ivony-Miaramiasa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 435, 33, 'Kianjandrakefina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 436, 33, 'Mahazina-Ambohipierenana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 437, 33, 'Marosoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 438, 33, 'Sahatsiho-Ambohimanjaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 439, 33, 'Tsarasaotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 440, 34, 'Alakamisy-Ambohimahazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 441, 34, 'Ankarinoro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 442, 34, 'Betsimisotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 443, 34, 'Fandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 444, 34, 'Fiadanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 445, 34, 'Imito');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 446, 34, 'Mahazoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 447, 34, 'Miarinavaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 448, 34, 'Milamaina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 449, 34, 'Sahamadio');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 450, 34, 'Sandrandahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 451, 34, 'Tatamalaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 452, 34, 'Tsarazaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 453, 35, 'Ambatomarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 454, 35, 'Ambohimahazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 455, 35, 'Ambohimilanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 456, 35, 'Ambohipo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 457, 35, 'Ambovombe-Afovoany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 458, 35, 'Andakatanikely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 459, 35, 'Andakatany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 460, 35, 'Anjoma-Nandihizana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 461, 35, 'Anjoman''ankona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 462, 35, 'Talata-Vohimena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 463, 36, 'Ambalavao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 464, 36, 'Ambinanindovoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 465, 36, 'Ambinanindroa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 466, 36, 'Ambohimahamasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 467, 36, 'Ambohimandroso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 468, 36, 'Andrainjato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 469, 36, 'Anjoma');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 470, 36, 'Ankaramena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 471, 36, 'Besoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 472, 36, 'Fenoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 473, 36, 'Iarintsena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 474, 36, 'Kirano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 475, 36, 'Mahazony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 476, 36, 'Manamisoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 477, 36, 'Miarinarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 478, 36, 'Sendrisoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 479, 36, 'Vohitsaoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 480, 37, 'Ambalakindresy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 481, 37, 'Ambatosoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 482, 37, 'Ambohimahasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 483, 37, 'Ambohinamboarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 484, 37, 'Ampitana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 485, 37, 'Ankafina-Tsarafidy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 486, 37, 'Ankerana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 487, 37, 'Befeta');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 488, 37, 'Camp-Robin');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 489, 37, 'Fiadanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 490, 37, 'Isaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 491, 37, 'Kalalao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 492, 37, 'Manandroy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 493, 37, 'Morafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 494, 37, 'Sahatona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 495, 37, 'Sahave');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 496, 37, 'Vohiposa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 497, 38, 'Fianarantsoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 498, 39, 'Ambatomainty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 499, 39, 'Fitampito');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 500, 39, 'Ikalamavony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 501, 39, 'Mangidy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 502, 39, 'Sakay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 503, 39, 'Solila');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 504, 39, 'Tanamarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 505, 39, 'Tsitondroina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 506, 40, 'Ambalamidera-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 507, 40, 'Ambondrona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 508, 40, 'Andoharanomaintso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 509, 40, 'Anjoma-Itsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 510, 40, 'Ankarinarivo-Manirisoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 511, 40, 'Fanjakana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 512, 40, 'Iavinomby-Vohibola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 513, 40, 'Isorana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 514, 40, 'Mahazoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 515, 40, 'Nasandratrony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 516, 40, 'Soatanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 517, 41, 'Alakamisy-Ambohimaha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 518, 41, 'Alatsinainy-Ialamarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 519, 41, 'Ambalakely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 520, 41, 'Ambalamahasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 521, 41, 'Andrainjato-Centre');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 522, 41, 'Andrainjato-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 523, 41, 'Androy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 524, 41, 'Fandrandava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 525, 41, 'Ialananindro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 526, 41, 'Ivoamba');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 527, 41, 'Mahatsinjony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 528, 41, 'Sahambavy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 529, 41, 'Taindambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 530, 42, 'Alakamisy-Itenina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 531, 42, 'Andranomiditra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 532, 42, 'Andranovorivato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 533, 42, 'Ankaromalaza-Mifanasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 534, 42, 'Ihazoara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 535, 42, 'Mahaditra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 536, 42, 'Mahasoabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 537, 42, 'Maneva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 538, 42, 'Soaindrana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 539, 42, 'Talata-Ampano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 540, 42, 'Vinanitelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 541, 42, 'Vohibato-Ouest');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 542, 42, 'Vohimarina-Lamosina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 543, 42, 'Vohitrafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 544, 43, 'Ambohimanga-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 545, 43, 'Ambohimiera');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 546, 43, 'Analampasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 547, 43, 'Androrangavola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 548, 43, 'Antaretra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 549, 43, 'Antsindra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 550, 43, 'Fasintsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 551, 43, 'Ifanadiana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 552, 43, 'Kelilalina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 553, 43, 'Maroharatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 554, 43, 'Marotoko');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 555, 43, 'Ranomafana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 556, 43, 'Tsaratanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 557, 44, 'Ambatofotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 558, 44, 'Ambohimisafy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 559, 44, 'Ambolomadinika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 560, 44, 'Ankarimbelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 561, 44, 'Belemoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 562, 44, 'Ifanirea');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 563, 44, 'Ikongo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 564, 44, 'Kalafotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 565, 44, 'Manampatrana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 566, 44, 'Maromiandra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 567, 44, 'Sahalanona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 568, 44, 'Tanakambana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 569, 44, 'Tolongoina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 570, 45, 'Ambahatrazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 571, 45, 'Ambahive');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 572, 45, 'Ambalaroka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 573, 45, 'Ambalavero');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 574, 45, 'Ambila');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 575, 45, 'Amboanjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 576, 45, 'Ambohitsara-M');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 577, 45, 'Amborondra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 578, 45, 'Ambotaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 579, 45, 'Ampasimanjeva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 580, 45, 'Ampasimboraka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 581, 45, 'Ampasipotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 582, 45, 'Analavory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 583, 45, 'Anorombato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 584, 45, 'Anosiala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 585, 45, 'Anteza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 586, 45, 'Bekatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 587, 45, 'Fenomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 588, 45, 'Lokomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 589, 45, 'Mahabako');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 590, 45, 'Mahamaibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 591, 45, 'Manakara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 592, 45, 'Mangatsiotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 593, 45, 'Marofarihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 594, 45, 'Mavorano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 595, 45, 'Mitanty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 596, 45, 'Mizilo-Gara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 597, 45, 'Nihaonana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 598, 45, 'Onilahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 599, 45, 'Sahanambohitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 600, 45, 'Saharefo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 601, 45, 'Sahasinaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 602, 45, 'Sakoana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 603, 45, 'Sorombo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 604, 45, 'Tataho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 605, 45, 'Vatana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 606, 45, 'Vinanitelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 607, 45, 'Vohilava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 608, 45, 'Vohimanitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 609, 45, 'Vohimasina-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 610, 45, 'Vohimasina-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 611, 45, 'Vohimasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 612, 46, 'Ambalahosy-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 613, 46, 'Ambodinonoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 614, 46, 'Ambohimiarina-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 615, 46, 'Ambohinihaonana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 616, 46, 'Andonabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 617, 46, 'Andranambolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 618, 46, 'Anosimparihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 619, 46, 'Antsenavolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 620, 46, 'Kianjavato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 621, 46, 'Mahaela');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 622, 46, 'Mahatsara-Iefaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 623, 46, 'Mahatsara-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 624, 46, 'Mahavoky-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 625, 46, 'Manakana-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 626, 46, 'Mananjary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 627, 46, 'Marofototra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 628, 46, 'Marokarima');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 629, 46, 'Marosangy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 630, 46, 'Morafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 631, 46, 'Namorona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 632, 46, 'Sandrohy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 633, 46, 'Tsaravary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 634, 46, 'Tsiatosika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 635, 46, 'Vatohandrina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 636, 46, 'Vohilava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 637, 47, 'Ambahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 638, 47, 'Ambodilafa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 639, 47, 'Ampasinambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 640, 47, 'Androrangovola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 641, 47, 'Befody');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 642, 47, 'Fiadanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 643, 47, 'NosyVarika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 644, 47, 'Sahavato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 645, 47, 'SoavinaEst');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 646, 47, 'Vohilava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 647, 47, 'Vohindroa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 648, 47, 'Vohitrandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 649, 48, 'Andemaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 650, 48, 'Ankarimbary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 651, 48, 'Ifatsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 652, 48, 'Ilakatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 653, 48, 'Ivato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 654, 48, 'Lanivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 655, 48, 'Mahabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 656, 48, 'Mahasoabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 657, 48, 'Mahazoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 658, 48, 'Nato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 659, 48, 'Onjatsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 660, 48, 'Sahalava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 661, 48, 'Savana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 662, 48, 'Vohilany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 663, 48, 'Vohindava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 664, 48, 'Vohipeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 665, 48, 'Vohitrindry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 666, 49, 'Antaninarenina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 667, 49, 'Antondabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 668, 49, 'Befotaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 669, 49, 'Befotaka-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 670, 49, 'Beharena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 671, 49, 'Marovitsika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 672, 49, 'Ranotsara-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 673, 50, 'Ambalatany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 674, 50, 'Ambalavato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 675, 50, 'Ambalavato-Antevato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 676, 50, 'Ambohigogo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 677, 50, 'Ambohimandroso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 678, 50, 'Amporoforo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 679, 50, 'Ankarana-Miraihina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 680, 50, 'Anosivelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 681, 50, 'Anosy-Tsararafa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 682, 50, 'Antsiranambe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 683, 50, 'Beretra-Bevoay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 684, 50, 'Efatsy-Anandroza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 685, 50, 'Etrotroka-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 686, 50, 'Evato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 687, 50, 'Farafangana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 688, 50, 'Fenoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 689, 50, 'Iabohazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 690, 50, 'Ihorombe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 691, 50, 'Ivandrika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 692, 50, 'Mahabo-Mananivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 693, 50, 'Mahafasa-Centre');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 694, 50, 'Mahavelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 695, 50, 'Maheriraty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 696, 50, 'Manambotra-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 697, 50, 'Marovandrika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 698, 50, 'Namohora-Iaborano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 699, 50, 'Sahamadio');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 700, 50, 'Tangainony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 701, 50, 'Tovona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 702, 50, 'Vohilengo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 703, 50, 'Vohimasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 704, 50, 'Vohitromby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 705, 51, 'Andranolalina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 706, 51, 'Ankazovelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 707, 51, 'Irondro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 708, 51, 'Maliorano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 709, 51, 'Midongy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 710, 51, 'Soakibany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 711, 52, 'Ambatolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 712, 52, 'Ambongo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 713, 52, 'Amparihy-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 714, 52, 'Ampasimalemy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 715, 52, 'Ampataka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 716, 52, 'Anilobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 717, 52, 'Bekaraoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 718, 52, 'Bema');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 719, 52, 'Bevata');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 720, 52, 'Fenoambany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 721, 52, 'Iara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 722, 52, 'Isahara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 723, 52, 'Karimbary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 724, 52, 'Lohafary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 725, 52, 'Lopary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 726, 52, 'Manambondro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 727, 52, 'Marokibo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 728, 52, 'Masianaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 729, 52, 'Matanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 730, 52, 'Ranomena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 731, 52, 'Sandravinany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 732, 52, 'Soamanova');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 733, 52, 'Tsianofana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 734, 52, 'Tsiately');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 735, 52, 'Vangaindrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 736, 52, 'Vatanato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 737, 52, 'Vohimalaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 738, 52, 'Vohipaho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 739, 52, 'Vohitrambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 740, 53, 'Ambohimana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 741, 53, 'Anandravy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 742, 53, 'Andakana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 743, 53, 'Antokonala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 744, 53, 'Iamonta');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 745, 53, 'Ivato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 746, 53, 'Karianga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 747, 53, 'Mahatsinjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 748, 53, 'Mahavelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 749, 53, 'Mahazoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 750, 53, 'Manambidala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 751, 53, 'Manato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 752, 53, 'Maroteza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 753, 53, 'Vohiboreka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 754, 53, 'Vohimary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 755, 53, 'Vondrozo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 756, 54, 'Begogo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 757, 54, 'Iakora');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 758, 54, 'Ranotsara-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 759, 55, 'Ambatolahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 760, 55, 'Ambia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 761, 55, 'Analaliry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 762, 55, 'Analavoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 763, 55, 'Andiolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 764, 55, 'Ankily');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 765, 55, 'Ihosy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 766, 55, 'Ilakaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 767, 55, 'Irina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 768, 55, 'Mahasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 769, 55, 'Menamaty-Iloto');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 770, 55, 'Ranohira');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 771, 55, 'Sahambano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 772, 55, 'Sakalalina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 773, 55, 'Satrokala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 774, 55, 'Soamatasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 775, 55, 'Zazafotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 776, 56, 'Antambohobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 777, 56, 'Ivohibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 778, 56, 'Ivongo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 779, 56, 'Maropaika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 780, 57, 'Ambaliha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 781, 57, 'Ambarijeby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 782, 57, 'Analalava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 783, 57, 'Andriambavontsona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 784, 57, 'Ankaramy-Be');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 785, 57, 'Antonibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 786, 57, 'Befotaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 787, 57, 'Mahadrodroka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 788, 57, 'Maromandia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 789, 57, 'Marovantaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 790, 57, 'Marovatolena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 791, 58, 'Ambimadiro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 792, 58, 'Ambodimanary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 793, 58, 'Ambodimandresy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 794, 58, 'Ampandriakalindy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 795, 58, 'Anahidrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 796, 58, 'Andreba');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 797, 58, 'Anjalazala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 798, 58, 'Anjiamangirana-I');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 799, 58, 'Ankerika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 800, 58, 'Antsahabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 801, 58, 'Antsohihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 802, 58, 'Maroala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 803, 59, 'Ambalaromba');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 804, 59, 'Ambatoriha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 805, 59, 'Ambatosia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 806, 59, 'Ambodiadabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 807, 59, 'Ambodisikidy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 808, 59, 'Ambonomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 809, 59, 'Analila');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 810, 59, 'Antananivo-Haut');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 811, 59, 'Antsamaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 812, 59, 'Bealanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 813, 59, 'Beandrarezona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 814, 59, 'Mangidrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 815, 59, 'Marotolana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 816, 60, 'Ambararata');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 817, 60, 'Ambodimotso-Atsimo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 818, 60, 'Ambolidibe-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 819, 60, 'Ankarongana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 820, 60, 'Antsakabary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 821, 60, 'Antsakanalabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 822, 60, 'Befandriana-Avaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 823, 60, 'Maroamalona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 824, 60, 'Matsondana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 825, 60, 'Morafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 826, 60, 'Tsarahonenana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 827, 60, 'Tsiamalao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 828, 61, 'Ambanjabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 829, 61, 'Ambodimahabibo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 830, 61, 'Ambodisakoana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 831, 61, 'Ambodivongo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 832, 61, 'Amparihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 833, 61, 'Andranomeva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 834, 61, 'Boriziny(Port-Bergé)');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 835, 61, 'BorizinyII');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 836, 61, 'Leanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 837, 61, 'Maevaranohely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 838, 61, 'Marovato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 839, 61, 'Tsarahasina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 840, 61, 'Tsaratanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 841, 61, 'Tsiningia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 842, 61, 'Tsinjomitondraka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 843, 62, 'Ambohitoaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 844, 62, 'Ampasimatera');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 845, 62, 'Bekoratsaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 846, 62, 'Komajia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 847, 62, 'Mampikony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 848, 62, 'Mampikony-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 849, 63, 'Ambalakirajy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 850, 63, 'Ambarikorano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 851, 63, 'Ambaripaika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 852, 63, 'Ambilombe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 853, 63, 'Amboaboa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 854, 63, 'Ambodiadabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 855, 63, 'Ambohisoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 856, 63, 'Amborondolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 857, 63, 'Ampatakamaroreny');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 858, 63, 'Andohajango');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 859, 63, 'Anjiabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 860, 63, 'Ankiabe-Salohy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 861, 63, 'Antanambaon''amberina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 862, 63, 'Antananadava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 863, 63, 'Antsatramidoladola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 864, 63, 'Antsirabe-Afovoany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 865, 63, 'Antsoha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 866, 63, 'Kalandy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 867, 63, 'Manampaneva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 868, 63, 'Mandritsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 869, 63, 'Marotandrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 870, 63, 'Tsaratanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 871, 64, 'AmbatoAmbarimay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 872, 64, 'Ambondromamy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 873, 64, 'Andranofasika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 874, 64, 'Andranomamy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 875, 64, 'Anjiajia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 876, 64, 'Ankijabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 877, 64, 'Ankirihitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 878, 64, 'Madirovalo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 879, 64, 'Manerinerina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 880, 64, 'Sitampiky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 881, 64, 'Tsaramandroso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 882, 65, 'Mahajanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 883, 66, 'Ambalabe-Befanjava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 884, 66, 'Ambalakida');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 885, 66, 'Andranoboka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 886, 66, 'Bekobay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 887, 66, 'Belobaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 888, 66, 'Betsako');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 889, 66, 'Boanamary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 890, 66, 'Mahajamba-Usine');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 891, 66, 'Mariarano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 892, 67, 'Ambolomoty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 893, 67, 'Ankaraobato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 894, 67, 'Ankazomborona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 895, 67, 'Anosinalainolona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 896, 67, 'Antanambao-Andranolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 897, 67, 'Antanimasaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 898, 67, 'Bemaharivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 899, 67, 'Manaratsandry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 900, 67, 'Marosakoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 901, 67, 'Marovoay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 902, 67, 'Marovoay-Banlieue');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 903, 67, 'Tsararano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 904, 68, 'Ambarimaninga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 905, 68, 'Antongomena-Bevary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 906, 68, 'Antseza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 907, 68, 'Bekipay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 908, 68, 'Katsepy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 909, 68, 'Matsakabanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 910, 68, 'Mitsinjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 911, 69, 'Ambohipaky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 912, 69, 'Andranomavo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 913, 69, 'Soalala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 914, 70, 'Ambaliha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 915, 70, 'Andasibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 916, 70, 'Antanimbaribe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 917, 70, 'Behazomaty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 918, 70, 'Betaimboay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 919, 70, 'Kandreho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 920, 71, 'Ambalajia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 921, 71, 'Ambalanjanakomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 922, 71, 'Andriba');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 923, 71, 'Antanimbary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 924, 71, 'Antsiafabositra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 925, 71, 'Bemokotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 926, 71, 'Beratsimanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 927, 71, 'Madiromirafy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 928, 71, 'Maevatanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 929, 71, 'Maevatanana-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 930, 71, 'Mahatsinjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 931, 71, 'Mahazoma');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 932, 71, 'Mangabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 933, 71, 'Maria');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 934, 71, 'Morafeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 935, 71, 'Tsararano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 936, 72, 'Ambakireny');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 937, 72, 'Andriamena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 938, 72, 'Bekapaika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 939, 72, 'Betrandraka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 940, 72, 'Brieville');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 941, 72, 'Keliloha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 942, 72, 'Manakana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 943, 72, 'Sarobaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 944, 72, 'Tsararova');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 945, 72, 'Tsaratanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 946, 73, 'Ambatomainty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 947, 73, 'Bemarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 948, 73, 'Marotsialeha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 949, 73, 'Sarodrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 950, 74, 'Antsalova');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 951, 74, 'Bekopaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 952, 74, 'Masoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 953, 74, 'Soahany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 954, 74, 'Trangahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 955, 75, 'Ambolodia-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 956, 75, 'Bekodoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 957, 75, 'Besalampy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 958, 75, 'Mahabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 959, 75, 'Marovoay-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 960, 75, 'Soanenga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 961, 76, 'Andabotoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 962, 76, 'Andranovao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 963, 76, 'Ankisatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 964, 76, 'Antsahidoha-Bebao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 965, 76, 'Antsondrodava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 966, 76, 'Bebakony-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 967, 76, 'Berevo-Ranobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 968, 76, 'Betanatanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 969, 76, 'Mafaijijo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 970, 76, 'Maintirano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 971, 76, 'Marohazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 972, 76, 'Maromavo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 973, 76, 'Tambohorano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 974, 76, 'Veromanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 975, 77, 'Andramy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 976, 77, 'Beravina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 977, 77, 'Morafenobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 978, 78, 'Ambandrika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 979, 78, 'Banlieue-d''Ambatondrazaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 980, 78, 'Ambatondrazaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 981, 78, 'Ambatosoratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 982, 78, 'Ambohitsilaozana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 983, 78, 'Amparihitsokatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 984, 78, 'Ampitatsimo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 985, 78, 'Andilanatoby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 986, 78, 'Andromba');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 987, 78, 'Antanandava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 988, 78, 'Antsangasanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 989, 78, 'Bejofo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 990, 78, 'Didy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 991, 78, 'Feramanga-Avaratra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 992, 78, 'Ilafy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 993, 78, 'Imerimandroso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 994, 78, 'Manakambahiny-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 995, 78, 'Manakambahiny-Ouest');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 996, 78, 'Soalazaina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 997, 78, 'Tanambao-Besakay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 998, 79, 'Ambatomainty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 999, 79, 'Amboavory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1000, 79, 'Ambohijanahary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1001, 79, 'Ambohitrarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1002, 79, 'Amparafaravola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1003, 79, 'Andrebakely-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1004, 79, 'Beanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1005, 79, 'Bedidy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1006, 79, 'Morarano-Chrome');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1007, 79, 'Ranomainty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1008, 79, 'Tanambe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1009, 79, 'Vohimena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1010, 79, 'Vohitsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1011, 80, 'Andilamena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1012, 80, 'Antanimenabaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1013, 80, 'Bemaitso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1014, 80, 'Maintsokely');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1015, 80, 'Maroadabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1016, 80, 'Marovato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1017, 80, 'Miarinarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1018, 80, 'Tanananifololahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1019, 81, 'Ambalaomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1020, 81, 'Ambatoharanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1021, 81, 'Ampandoantraka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1022, 81, 'Ampasimaneva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1023, 81, 'Anosibe-An''ala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1024, 81, 'Antandrokomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1025, 81, 'Longozabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1026, 81, 'Niarovana-Marosampanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1027, 81, 'Tratramarina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1028, 82, 'Ambatovola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1029, 82, 'Amboasary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1030, 82, 'Ambohidronono');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1031, 82, 'Ampasipotsy-Gare');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1032, 82, 'Ampasipotsy-Mandialaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1033, 82, 'Andaingo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1034, 82, 'Andasibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1035, 82, 'Anosibe-Ifody');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1036, 82, 'Antanandava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1037, 82, 'Antaniditra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1038, 82, 'Beforona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1039, 82, 'Belavabary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1040, 82, 'Beparasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1041, 82, 'Fierenana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1042, 82, 'Lakato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1043, 82, 'Mandialaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1044, 82, 'Moramanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1045, 82, 'Moramanga-Suburbaine');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1046, 82, 'MoraranoGare');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1047, 82, 'Sabotsy-Anjiro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1048, 82, 'Vodiriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1049, 83, 'Antanambao-Manampotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1050, 83, 'Antanandehibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1051, 83, 'Mahela');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1052, 83, 'Manakana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1053, 83, 'Saivaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1054, 84, 'Ambalarondra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1055, 84, 'Ambinaninony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1056, 84, 'Ambohimanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1057, 84, 'Ampasimbe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1058, 84, 'Andekaleka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1059, 84, 'Andevoranto');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1060, 84, 'Anivorano-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1061, 84, 'Anjahamana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1062, 84, 'Vohibinany-Brickaville');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1063, 84, 'Fanasana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1064, 84, 'Fetraomby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1065, 84, 'Lohariandava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1066, 84, 'Mahatsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1067, 84, 'Maroseranana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1068, 84, 'Ranomafana-Est');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1069, 84, 'Razanaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1070, 84, 'Vohitranivona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1071, 85, 'Ambinanidilana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1072, 85, 'Ambinanindrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1073, 85, 'Ambodibonara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1074, 85, 'Ambodiharina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1075, 85, 'Ankazotsifantatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1076, 85, 'Befotaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1077, 85, 'Betsizaraina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1078, 85, 'Mahanoro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1079, 85, 'Manjakandriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1080, 85, 'Masomeloka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1081, 85, 'Tsaravinany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1082, 86, 'Ambalapaiso-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1083, 86, 'Amboasary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1084, 86, 'Ambodinonoka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1085, 86, 'Ambohimilanja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1086, 86, 'Anbatofisaka-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1087, 86, 'Andonabe-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1088, 86, 'Androrangavola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1089, 86, 'Anosiarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1090, 86, 'Betampona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1091, 86, 'Lohavanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1092, 86, 'Marolambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1093, 86, 'Sahakevo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1094, 87, 'Ambodimanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1095, 87, 'Ankirihiry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1096, 87, 'Firaisana-Anjoma');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1097, 87, 'Morarano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1098, 87, 'Tanambao-V');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1099, 88, 'Ambodilazana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1100, 88, 'Ambodiriana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1101, 88, 'Amboditandroho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1102, 88, 'AmpasibeOnibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1103, 88, 'Ampasimadinika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1104, 88, 'Andondabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1105, 88, 'Andranobolaha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1106, 88, 'Antenina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1107, 88, 'Antetezambaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1108, 88, 'Fanandrana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1109, 88, 'Foulpointe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1110, 88, 'Ifito');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1111, 88, 'Mangabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1112, 88, 'Sahambala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1113, 88, 'Toamasina-suburbaine');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1114, 89, 'Ambalabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1115, 89, 'Ambalavolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1116, 89, 'Amboditavolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1117, 89, 'Ambodivoananto');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1118, 89, 'Ampasimadinika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1119, 89, 'Ampasimazava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1120, 89, 'AntanambaoMahatsara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1121, 89, 'IfasinaI');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1122, 89, 'IfasinaII');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1123, 89, 'IlakaEst');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1124, 89, 'Maintinandry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1125, 89, 'Nierenana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1126, 89, 'Sahamatevina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1127, 89, 'TanambaoVahatrakaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1128, 89, 'Tsivangiana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1129, 89, 'Vatomandry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1130, 90, 'Ambatoharanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1131, 90, 'Ambodimanga-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1132, 90, 'Ampasimbe-Manantsatrana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1133, 90, 'Ampasina-Maningory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1134, 90, 'Antsiatsiaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1135, 90, 'Fenoarivo-Atsinanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1136, 90, 'Mahambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1137, 90, 'Miorimivalana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1138, 90, 'Saranambana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1139, 90, 'Vohilengo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1140, 90, 'Vohipeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1141, 91, 'Ambatoharanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1142, 91, 'Ambodiampana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1143, 91, 'Ambodivoanio');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1144, 91, 'Antanambaobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1145, 91, 'Antanambe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1146, 91, 'Manambolosy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1147, 91, 'Mananara-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1148, 91, 'Sandrakatsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1149, 91, 'Saromaona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1150, 91, 'Tanibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1151, 91, 'Vanono');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1152, 92, 'Ambinanitelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1153, 92, 'Andranofotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1154, 92, 'Androndrono');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1155, 92, 'Anjanazana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1156, 92, 'Ankofa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1157, 92, 'Antakotako');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1158, 92, 'Antsahana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1159, 92, 'Antsirabe-Sahatany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1160, 92, 'Manambolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1161, 92, 'Maroantsetra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1162, 92, 'Rantabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1163, 92, 'Voloina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1164, 93, 'Sainte-Marie/NosyBoraha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1165, 94, 'Ambahoabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1166, 94, 'Ambodiampana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1167, 94, 'Andapafito');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1168, 94, 'Antanifotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1169, 94, 'Antenina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1170, 94, 'Fotsialanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1171, 94, 'Manompana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1172, 94, 'Soanierana-Ivongo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1173, 95, 'Ambatoharanana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1174, 95, 'Ambodimangavalo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1175, 95, 'Ambohibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1176, 95, 'Ampasimazava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1177, 95, 'Andasibe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1178, 95, 'Anjahambe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1179, 95, 'Maromitety');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1180, 95, 'Miarinarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1181, 95, 'Sahatavy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1182, 95, 'Vavatenina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1183, 96, 'Ambiky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1184, 96, 'Amboalimena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1185, 96, 'Andimaky-Manambolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1186, 96, 'Ankalalobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1187, 96, 'Ankiliroroka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1188, 96, 'Ankirondro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1189, 96, 'Antsoha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1190, 96, 'Belinta');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1191, 96, 'Belon''i-Tsiribihina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1192, 96, 'Berevo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1193, 96, 'Beroboka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1194, 96, 'Masoarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1195, 96, 'Tsaraotana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1196, 96, 'Tsimafana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1197, 97, 'Ambia');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1198, 97, 'Ampanihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1199, 97, 'Analamitsivala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1200, 97, 'Ankilivalo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1201, 97, 'Ankilizato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1202, 97, 'Befotaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1203, 97, 'Beronono');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1204, 97, 'Mahabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1205, 97, 'Malaimbandy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1206, 97, 'Mandabe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1207, 97, 'Tsimazava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1208, 98, 'Andranopasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1209, 98, 'Ankiliabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1210, 98, 'AnontsibeCentre');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1211, 98, 'Beharona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1212, 98, 'Manja');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1213, 98, 'Soaserana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1214, 99, 'Ambatolahy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1215, 99, 'Ampanihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1216, 99, 'Ankavandra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1217, 99, 'Ankondromena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1218, 99, 'Ankotrofotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1219, 99, 'Anosimena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1220, 99, 'Bemahatazana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1221, 99, 'Betsipolitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1222, 99, 'Dabolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1223, 99, 'Isalo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1224, 99, 'Itondy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1225, 99, 'Manambina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1226, 99, 'Manandaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1227, 99, 'Miandrivazo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1228, 99, 'Soaloka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1229, 100, 'Analaiva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1230, 100, 'Befasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1231, 100, 'BelosurMer');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1232, 100, 'Bemanonga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1233, 100, 'Morondava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1234, 101, 'Amboropotsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1235, 101, 'Ampanihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1236, 101, 'Androka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1237, 101, 'Ankiliabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1238, 101, 'Ankilimivory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1239, 101, 'Ankilizato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1240, 101, 'Antaly');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1241, 101, 'Beahitse');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1242, 101, 'Belafike');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1243, 101, 'Beroy-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1244, 101, 'Ejeda');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1245, 101, 'Fotadrevo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1246, 101, 'Gogogogo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1247, 101, 'Itampolo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1248, 101, 'Maniry');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1249, 101, 'Vohitany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1250, 102, 'Andranomafana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1251, 102, 'Ankazoabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1252, 102, 'Berenty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1253, 102, 'Tandrano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1254, 103, 'Benenitra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1255, 103, 'Ehara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1256, 103, 'Ianapera');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1260, 104, 'Andranomangatsiaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1261, 104, 'Antohabato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1262, 104, 'Beantake');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1263, 104, 'Beavoha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1264, 104, 'Belamoty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1265, 104, 'Betioky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1266, 104, 'Bezaha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1267, 104, 'Fenoandala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1268, 104, 'Lazarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1269, 104, 'Manalobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1270, 104, 'Masiaboay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1271, 104, 'Montifeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1272, 104, 'Salobe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1273, 104, 'Soamanonga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1274, 104, 'Soaserana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1275, 104, 'Tameantsoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1276, 104, 'TanambaoAmbony');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1277, 104, 'Tongobory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1278, 104, 'Vatolatsaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1279, 105, 'Behisatra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1280, 105, 'Beroroha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1281, 105, 'Bemavo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1282, 105, 'Fanjakana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1283, 105, 'Mandronarivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1284, 105, 'Marerano');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1285, 105, 'Sakena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1286, 105, 'Tanamary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1287, 105, 'Vondrove');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1288, 106, 'Ambahikily');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1289, 106, 'Antanimeva');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1290, 106, 'AntongoVaovao');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1291, 106, 'Basibasy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1292, 106, 'Befandefa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1293, 106, 'BefandrianaSud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1294, 106, 'Morombe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1295, 106, 'NosyAmbositra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1296, 107, 'Ambinany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1297, 107, 'Amboronabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1298, 107, 'Andamasina-Vineta');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1299, 107, 'Andranolava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1300, 107, 'Bereketa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1301, 107, 'Mahaboboka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1302, 107, 'Miary-Lamatihy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1303, 107, 'Miary-Taheza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1304, 107, 'Mihavatsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1305, 107, 'Mikoboka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1306, 107, 'Mitsinjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1307, 107, 'Sakaraha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1308, 108, 'Toliara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1309, 109, 'Ambohimahavelona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1310, 109, 'Ambolofoty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1311, 109, 'Analamisampy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1312, 109, 'Andranovory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1313, 109, 'Ankililoake');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1314, 109, 'Ankilimalinike');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1315, 109, 'Antanimena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1316, 109, 'Beheloke');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1317, 109, 'Behompy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1318, 109, 'Belalanda');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1319, 109, 'Mandrofify');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1320, 109, 'Manombo-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1321, 109, 'Marofoty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1322, 109, 'Maromiandra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1323, 109, 'Miary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1324, 109, 'Milenaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1325, 109, 'Saint-Augustin');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1326, 109, 'Soalara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1327, 109, 'Tsianisiha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1328, 110, 'Ambanisarike');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1329, 110, 'Ambazoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1330, 110, 'Ambohimalaza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1331, 110, 'Ambonaivo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1332, 110, 'Ambondro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1333, 110, 'Ambovombe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1334, 110, 'Ampamata');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1335, 110, 'Andalatanosy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1336, 110, 'Anjeky-Ankilikira');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1337, 110, 'Antanimora-Sud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1338, 110, 'Imanombo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1339, 110, 'Erada');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1340, 110, 'Jafaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1341, 110, 'Maroalomainty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1342, 110, 'Maroalopoty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1343, 110, 'Marovato-Befeno');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1344, 110, 'Sihanamaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1345, 111, 'Ambahita');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1346, 111, 'Ambatosola');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1347, 111, 'Anivorano-Mitsinjo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1348, 111, 'Anja-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1349, 111, 'Ankaranabo-Nord');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1350, 111, 'Antsakoamaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1351, 111, 'Bekitro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1352, 111, 'Belindo-Mahasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1353, 111, 'Beraketa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1354, 111, 'Beteza');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1355, 111, 'Bevitiky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1356, 111, 'Manakompy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1357, 111, 'Maroviro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1358, 111, 'MorafenoBekily');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1359, 111, 'TanambaoTsirandrana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1360, 111, 'Tanandava');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1361, 111, 'Tsikolaky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1362, 111, 'Vohimanga');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1363, 112, 'Beloha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1364, 112, 'Kopoky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1365, 112, 'Marolinta');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1366, 112, 'Tranoroa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1367, 112, 'Tranovaho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1368, 113, 'Antaritarika');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1369, 113, 'Faux-Cap');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1370, 113, 'Imongy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1371, 113, 'Marovato');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1372, 113, 'Tsihombe');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1373, 114, 'Amboasary-Atsimo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1374, 114, 'Behara');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1375, 114, 'Ebelo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1376, 114, 'Elonty');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1377, 114, 'Esira');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1378, 114, 'Ifotaka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1379, 114, 'Mahaly');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1380, 114, 'Manevy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1381, 114, 'Maromby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1382, 114, 'Marotsiraka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1383, 114, 'Sampona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1384, 114, 'TanandavaSud');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1385, 114, 'Tranomaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1386, 114, 'Tsivory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1387, 115, 'Ambalasoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1388, 115, 'Ambatomivary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1389, 115, 'Analamary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1390, 115, 'Andriandampy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1391, 115, 'Beapombo-I');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1392, 115, 'Beapombo-II');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1393, 115, 'Bekorobo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1394, 115, 'Benato-Toby');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1395, 115, 'Betroka');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1396, 115, 'Iaborotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1397, 115, 'Ianabinda');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1398, 115, 'Ianakafy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1399, 115, 'Isoanala');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1400, 115, 'Ivahona');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1401, 115, 'Jangany');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1402, 115, 'Mahabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1403, 115, 'MahasoaEst');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1404, 115, 'Nagnarena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1405, 115, 'Naninora');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1406, 115, 'Tsaraitso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1407, 116, 'Ambatoabo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1408, 116, 'Ampasimena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1409, 116, 'AmpasyNahampoa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1410, 116, 'Analamary');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1411, 116, 'Analapatsy');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1412, 116, 'Andranombory');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1413, 116, 'Ankaramena');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1414, 116, 'Bevoay');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1415, 116, 'Enakara-Haut');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1416, 116, 'Enaniliha');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1417, 116, 'Fenoevo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1418, 116, 'Iabakoho');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1419, 116, 'Ifarantsa');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1420, 116, 'Isaka-Ivondro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1421, 116, 'Mahatalaky');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1422, 116, 'Manambaro');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1423, 116, 'Manantenina');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1424, 116, 'Mandiso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1425, 116, 'Mandromodromotra');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1426, 116, 'Ranomafana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1427, 116, 'Ranopiso');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1428, 116, 'Sarasambo');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1429, 116, 'Soanierana');
INSERT INTO "public".communes( id, district_id, name ) VALUES ( 1430, 116, 'Tôlanaro');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 2, null, '2023-12-05 02:30:00 AM', 4, 'dsfdsf', '2023-12-05 01:57:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 3, null, '2023-12-05 03:03:00 AM', 4, 'dqsdsqd', '2023-12-05 02:30:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 4, null, '2023-12-05 04:44:00 PM', 4, 'Mety', '2023-12-05 04:11:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 5, null, '2023-12-05 04:44:00 PM', 4, '', '2023-12-05 04:11:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 6, null, '2023-12-05 04:44:00 PM', 4, '', '2023-12-05 04:11:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 7, null, '2023-12-05 05:17:00 PM', 4, '', '2023-12-05 04:44:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 8, null, '2023-12-05 05:50:00 PM', 4, '', '2023-12-05 05:17:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 12, null, '2023-12-06 04:09:00 AM', 4, '', '2023-12-06 03:36:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 11, null, '2023-12-06 03:36:00 AM', 4, '', '2023-12-06 03:03:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 10, null, '2023-12-06 03:03:00 AM', 4, '', '2023-12-06 02:30:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 31, null, '2023-12-08 01:39:00 PM', 7, '', '2023-12-08 01:06:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 27, null, '2023-12-08 01:06:00 PM', 7, '', '2023-12-08 12:33:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 16, null, '2023-12-06 04:09:00 AM', 4, '', '2023-12-06 03:36:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 17, null, '2023-12-06 03:03:00 AM', 4, '', '2023-12-06 02:30:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 18, null, '2023-12-06 03:36:00 AM', 4, '', '2023-12-06 03:03:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 21, null, '2023-12-06 04:09:00 AM', 4, '', '2023-12-06 03:36:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 20, null, '2023-12-06 03:36:00 AM', 4, '', '2023-12-06 03:03:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 19, null, '2023-12-06 03:03:00 AM', 4, '', '2023-12-06 02:30:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 24, null, '2023-12-07 03:31:00 PM', 4, '', '2023-12-07 02:58:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 22, null, '2023-12-06 03:03:00 AM', 4, '', '2023-12-06 02:30:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 23, null, '2023-12-06 03:36:00 AM', 4, 'd', '2023-12-06 03:03:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 25, null, '2023-12-06 03:03:00 AM', 4, '', '2023-12-06 02:30:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 26, null, '2023-12-08 12:33:00 PM', 4, 'Marary be ', '2023-12-08 12:00:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 15, null, '2023-12-05 05:50:00 PM', 6, '', '2023-12-05 05:17:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 33, null, '2023-12-08 12:33:00 PM', 7, 'Marary', '2023-12-08 12:00:00 PM', 88, 62, 42, null);
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 13, '{"doctorName":"null tttttttt sqdvsdveeeeeeeeee","date":"Dec 5, 2023","time":"04:11:00 PM","symptoms":["marary"],"prescriptions":[{"medicament":"\"paracetamol\"","medicamentType":"","duration":1,"day":1.0,"evening":1.0,"night":1.0}]}', '2023-12-05 04:44:00 PM', 5, '', '2023-12-05 04:11:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 14, '{"doctorName":"null tttttttt sqdvsdveeeeeeeeee","date":"Dec 5, 2023","time":"04:44:00 PM","symptoms":["marary"],"prescriptions":[{"medicament":"moly","medicamentType":"","duration":4,"day":1.0,"evening":1.0,"night":1.0}]}', '2023-12-05 05:17:00 PM', 5, '', '2023-12-05 04:44:00 PM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 9, null, '2023-12-06 02:30:00 AM', 8, '', '2023-12-06 01:57:00 AM', 88, 62, 42, '2023-12-06 03:25:03 PM');
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 34, null, '2023-12-08 02:12:00 PM', 3, 'test report', '2023-12-08 01:39:00 PM', 88, 62, 42, null);
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 36, null, '2023-12-08 02:45:00 PM', 3, 'Dev', '2023-12-08 02:12:00 PM', 88, 62, 42, null);
INSERT INTO "public".event( id, consultation, end_dt, event_type_id, reason, start_dt, healthpro_id, patient_id, user_id, created_at ) VALUES ( 37, null, '2023-12-06 07:16:00 PM', 3, 'documenteo', '2023-12-06 06:43:00 PM', 88, 62, 42, null);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 399, '2023-11-29 06:18:03 PM', '2023-11-30 10:58:03 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxMjcxMDgzLCJleHAiOjE3MDEzMzEwODN9.2JIfpGRGDacVRFrbWQ88nXGjG8xqLVjydY6OIylKe1M', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 400, '2023-11-29 06:26:38 PM', '2023-11-30 11:06:38 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxMjcxNTk4LCJleHAiOjE3MDEzMzE1OTh9.5RMFEsufebL5DK5zK77kGf1K_N3d_h88oVnvdrHNwfg', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 401, '2023-12-04 09:06:24 AM', '2023-12-04 09:18:52 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2Njk5ODQsImV4cCI6MTcwMTcyOTk4NH0.4NhwkbOopMI2CLxSHJmy3Ld7o69y6M52LFn3niSR3rk', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 402, '2023-12-04 09:19:20 AM', '2023-12-04 09:57:26 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTY3MDc2MCwiZXhwIjoxNzAxNzMwNzYwfQ.OEP7caD-3Cj2lJnYlnSKL9RmJU4l_hLdrw5qUrzCSa4', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 403, '2023-12-04 09:59:17 AM', '2023-12-04 10:07:58 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNzc3MiLCJpZCI6NDQsInN1YiI6Imdlbnljb0BnbWFpbC5jb20iLCJpYXQiOjE3MDE2NzMxNTcsImV4cCI6MTcwMTczMzE1N30.leT1Glzs151ZCmw_iVFxxRypPXpHVbHO2WdXFKk-1tg', 44);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 404, '2023-12-04 10:08:06 AM', '2023-12-05 02:48:06 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2NzM2ODYsImV4cCI6MTcwMTczMzY4Nn0.v2k4POhgqQgqelrpUpHqkalVYL_vL6YIf29CIiCEbAw', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 405, '2023-12-04 10:10:21 AM', '2023-12-04 10:37:44 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2NzM4MjEsImV4cCI6MTcwMTczMzgyMX0.wYdWmPtwhbwnSNFi2IU-ufPw2MbIkTTxKfa60S9r9-k', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 406, '2023-12-04 10:37:59 AM', '2023-12-05 03:17:59 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2NzU0NzksImV4cCI6MTcwMTczNTQ3OX0.0qX0Yo9OqD4vszxYNb3B0s201BIFjU9tRfSaGt1Vq7A', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 407, '2023-12-04 11:05:10 AM', '2023-12-04 11:19:15 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2NzcxMTAsImV4cCI6MTcwMTczNzExMH0.xvYI5XoX5kBlp_AFVdPq7bXZ1qmdiMDG0KDlmzWoUJE', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 408, '2023-12-04 11:19:23 AM', '2023-12-05 03:59:23 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3FkdnNkdiIsImlkIjo0NSwic3ViIjoicGFwYUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2Nzc5NjMsImV4cCI6MTcwMTczNzk2M30.FYeaNprTeLZH61LoIxHvUcsWYQ_isnt11HqhtiEIZ5A', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 409, '2023-12-04 11:19:33 AM', '2023-12-04 11:19:45 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTY3Nzk3MywiZXhwIjoxNzAxNzM3OTczfQ.bnCx-HLWTnfRBvKk8g8EMfrPS1w8Hh-ABhFr5ISuoHs', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 410, '2023-12-04 11:19:50 AM', '2023-12-04 11:33:31 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNjc3OTkwLCJleHAiOjE3MDE3Mzc5OTB9.NHJjFJ3cec_PUPckFAnYtFjSxWTqmVpHUHJNPilVUtI', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 412, '2023-12-04 11:33:37 AM', '2023-12-04 11:53:45 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNjc4ODE3LCJleHAiOjE3MDE3Mzg4MTd9.HbGzebtuc9PzgMJ72RnCjIjdbmWviCPINEQt04MQ0Mo', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 413, '2023-12-04 11:53:55 AM', '2023-12-04 01:13:15 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTY4MDAzNSwiZXhwIjoxNzAxNzQwMDM1fQ.uNPJWVqZSaVUi-L9P_vEvN-o-qvxf48CMI7ggcHnoXw', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 414, '2023-12-04 01:13:27 PM', '2023-12-05 05:53:27 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3FkdnNkdiIsImlkIjo0NSwic3ViIjoicGFwYUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2ODQ4MDcsImV4cCI6MTcwMTc0NDgwN30._kiwRgBQDhgapnHR6LncFbsnkINtHNXDf8hva2yUzb8', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 415, '2023-12-04 01:13:51 PM', '2023-12-04 01:14:08 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTY4NDgzMSwiZXhwIjoxNzAxNzQ0ODMxfQ.5DjxvGXH8gZLRPSet9tf_t4CqpEqGTDQDt2Hl2lYvhM', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 416, '2023-12-04 01:14:12 PM', '2023-12-04 01:16:21 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNjg0ODUyLCJleHAiOjE3MDE3NDQ4NTJ9.TBz12m96iN2mXjpRotbCPucwOzAUTg-BsUQGGKUNLcE', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 417, '2023-12-04 01:17:12 PM', '2023-12-04 01:17:43 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2ODUwMzIsImV4cCI6MTcwMTc0NTAzMn0.up8E9dyx59fnJppTj-zB2729tPNGdQEuRQ9SHcaI2KY', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 411, '2023-12-04 11:20:53 AM', '2023-12-04 01:20:13 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2NzgwNTMsImV4cCI6MTcwMTczODA1M30.UkwWtvnIOTTzd-fwZBArg0bga6Go50OCz2n4FEoYFvE', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 418, '2023-12-04 01:17:54 PM', '2023-12-04 01:20:20 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNjg1MDc0LCJleHAiOjE3MDE3NDUwNzR9.kGjUYjCNVDT_yiqyObq9lheogc0R5jW67ndXc08KBRM', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 420, '2023-12-04 02:09:34 PM', '2023-12-05 06:49:34 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2ODgxNzQsImV4cCI6MTcwMTc0ODE3NH0.jnjc_CcyjVNHhahRjmnWzwlOjpGqaOo6xsKlCkPpYJQ', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 419, '2023-12-04 01:20:26 PM', '2023-12-04 02:30:39 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNjg1MjI2LCJleHAiOjE3MDE3NDUyMjZ9.m8F6RdeJ0ageWoCWtw12r1HdzhbGl19RrSgpIIkVhig', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 421, '2023-12-04 02:41:10 PM', '2023-12-04 03:05:40 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE2OTAwNzAsImV4cCI6MTcwMTc1MDA3MH0.RF07rm77TJeHz6NSOO7NOKd0NtgKatWhOS0GKUm9k6Y', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 422, '2023-12-04 03:05:47 PM', '2023-12-04 05:59:15 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTY5MTU0NywiZXhwIjoxNzAxNzUxNTQ3fQ.FexUvBW07MTGwspFfl1n-N04_H2MImexsQ8p3U0j_Vs', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 423, '2023-12-04 05:59:21 PM', '2023-12-05 10:39:21 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3FkdnNkdiIsImlkIjo0NSwic3ViIjoicGFwYUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3MDE5NjEsImV4cCI6MTcwMTc2MTk2MX0.8pyvbqjDQyQJ-FP3VRu2uYJk7MIFgMLWFztzLtkmzMs', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 424, '2023-12-04 05:59:27 PM', '2023-12-04 05:59:44 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTcwMTk2NywiZXhwIjoxNzAxNzYxOTY3fQ.nehqDmN3svUDf6AduvNuYdNI75VGnsuzk7JGudDECaM', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 425, '2023-12-04 06:02:42 PM', '2023-12-04 06:50:07 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTcwMjE2MiwiZXhwIjoxNzAxNzYyMTYyfQ.lsveuCe5m7_1o9_d5zNc-3ajUNICSAaiwxEhNxmXQao', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 426, '2023-12-04 06:50:29 PM', '2023-12-04 07:16:53 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNzA1MDI5LCJleHAiOjE3MDE3NjUwMjl9.jhX63fN6uizdBCOanjpEYfJmk2cl-h9df3fU7KdKUWA', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 427, '2023-12-04 07:16:57 PM', '2023-12-04 07:39:00 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTcwNjYxNywiZXhwIjoxNzAxNzY2NjE3fQ.zZCOtebu856CiQZ6zI-0X59lXycVQBQLPw5zXTY8Al8', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 428, '2023-12-04 07:39:05 PM', '2023-12-04 07:49:49 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNzA3OTQ1LCJleHAiOjE3MDE3Njc5NDV9.kNCzqYMrS6KByZNhhtu66JIkDDVa04DC7SPJhko3614', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 429, '2023-12-04 07:55:55 PM', '2023-12-05 12:35:55 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3MDg5NTUsImV4cCI6MTcwMTc2ODk1NX0.UUDAWiqNNisvHIOBHY0GlsyxFPPX-nVG_jPJ-1p-0_8', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 430, '2023-12-04 08:09:13 PM', '2023-12-05 12:49:13 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTcwOTc1MywiZXhwIjoxNzAxNzY5NzUzfQ.bzDdUZ6nrcDMmHy55h3Fm6jA0ofZcHP58Rnp_-54f4k', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 431, '2023-12-04 10:33:53 PM', '2023-12-05 05:51:38 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTcxODQzMywiZXhwIjoxNzAxNzc4NDMzfQ.9DI-avhp1kGhxSFziERRRMgg_qSSDsFmagWGG1aD1OE', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 432, '2023-12-05 05:55:14 AM', '2023-12-05 06:09:30 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NDQ5MTQsImV4cCI6MTcwMTgwNDkxNH0.nnVJsjnNhFj5RtrO0G4aA3hUcVLHCvVF6VXSzQRP_Wg', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 433, '2023-12-05 06:09:35 AM', '2023-12-05 06:10:12 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc0NTc3NSwiZXhwIjoxNzAxODA1Nzc1fQ.g9cSqMwqCuFdh20VlUoBtAH-xYaUg4vCAxwV_5lO7DY', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 434, '2023-12-05 06:10:17 AM', '2023-12-05 10:50:17 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc0NTgxNywiZXhwIjoxNzAxODA1ODE3fQ.SRWzO808Wb0vEvqdfbbX0fAId9NpCoi_VLZIB6tMbXs', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 435, '2023-12-05 06:47:26 AM', '2023-12-05 06:47:41 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3FkdnNkdiIsImlkIjo0NSwic3ViIjoicGFwYUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NDgwNDYsImV4cCI6MTcwMTgwODA0Nn0.cEF3CTG1KY7jnfJfn7j30azHg6MP3aB8g9KAgJNlP9Y', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 436, '2023-12-05 06:47:47 AM', '2023-12-05 11:27:47 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc0ODA2NywiZXhwIjoxNzAxODA4MDY3fQ.VNKIV-j0QjuKWWKDoh5cF-eW8tXZXKhxkTLlPkaQUaI', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 437, '2023-12-05 06:48:02 AM', '2023-12-05 11:28:02 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHYiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxNzQ4MDgyLCJleHAiOjE3MDE4MDgwODJ9.3yLNRIMOwR0ujxgIECtyVbI8-IseaSKacqZhOOH5cBQ', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 438, '2023-12-05 09:28:57 AM', '2023-12-06 02:08:57 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTc3MzcsImV4cCI6MTcwMTgxNzczN30.6fxRl_633mL1fhb8BJNzgIGggtw4SiULODXOGlvSb-0', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 439, '2023-12-05 09:36:42 AM', '2023-12-05 09:40:00 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTgyMDIsImV4cCI6MTcwMTgxODIwMn0.UqjieVhjPH9ia0EkemC3cqb9Jvd_cNBICTY1_rdgMvY', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 440, '2023-12-05 09:40:05 AM', '2023-12-05 09:42:33 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTg0MDUsImV4cCI6MTcwMTgxODQwNX0.bAUqvFTz--r2kImxv-wxp2BciLiA-wJ7SPklyZYfbqg', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 441, '2023-12-05 09:42:39 AM', '2023-12-05 09:46:01 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTg1NTksImV4cCI6MTcwMTgxODU1OX0.tXHYCTIOcReFCN8BarWQ3QTnPLRAkvB9txxWCS0A5mI', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 442, '2023-12-05 09:46:10 AM', '2023-12-05 09:49:04 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTg3NzAsImV4cCI6MTcwMTgxODc3MH0.6HKgQQnJrNiR1SFpYZOZRXySIL7HSaD3PiFjzdw-LXc', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 443, '2023-12-05 09:49:08 AM', '2023-12-05 09:51:55 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTg5NDgsImV4cCI6MTcwMTgxODk0OH0.oDkEWF3ldUFrERypcoeF6fTlHTb8eR8TCP7kRlVo-uI', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 444, '2023-12-05 09:52:00 AM', '2023-12-05 09:52:11 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTkxMjAsImV4cCI6MTcwMTgxOTEyMH0.kJcX4oWhftdl3qvT-k54zdrOiRwc2vGO1nMJH_lVWds', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 445, '2023-12-05 09:52:20 AM', '2023-12-05 09:53:16 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTkxNDAsImV4cCI6MTcwMTgxOTE0MH0.maVP4yzU_GUn9C9R540F39HWpCWhyWqilBM2_Uuj1nU', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 446, '2023-12-05 09:53:22 AM', '2023-12-05 09:56:43 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTkyMDIsImV4cCI6MTcwMTgxOTIwMn0.ikU2A2jGcoUgSNBDKwn2RwcNn2auDYSQJyoOMtyRQhQ', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 447, '2023-12-05 09:56:47 AM', '2023-12-05 10:00:09 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTk0MDcsImV4cCI6MTcwMTgxOTQwN30.LXYLKitbktvxv5P8NlGJVvPlW7VHk1zf2tQUa8UJkVE', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 448, '2023-12-05 10:00:13 AM', '2023-12-05 10:00:27 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTk2MTMsImV4cCI6MTcwMTgxOTYxM30.pLOYqBYfR25pCcvbpHqLPbga3scsECmHy9AdZz0ftBk', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 450, '2023-12-05 10:12:22 AM', '2023-12-06 02:52:22 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc2MDM0MiwiZXhwIjoxNzAxODIwMzQyfQ.lRktmD9eFwyzUh3xOj7Jy5azvSZqITDWOm2NMYJG3VI', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 449, '2023-12-05 10:00:30 AM', '2023-12-05 10:13:33 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NTk2MzAsImV4cCI6MTcwMTgxOTYzMH0.vChg05OBuAA4lytf-P3E8T0DKgE3t9otuRfkk0hBPMg', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 451, '2023-12-05 10:13:37 AM', '2023-12-05 10:22:22 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NjA0MTcsImV4cCI6MTcwMTgyMDQxN30.5xD9UATKyUvoAbAQmGiASZBsqv_jT-aS2p70bytJlt0', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 453, '2023-12-05 10:36:17 AM', '2023-12-06 03:16:17 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NjE3NzcsImV4cCI6MTcwMTgyMTc3N30.p8u6ABG0sG_DTnotL_R6McoYjfgp9-OKccAv7MaO0SU', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 452, '2023-12-05 10:22:27 AM', '2023-12-05 10:37:09 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NjA5NDcsImV4cCI6MTcwMTgyMDk0N30.nBuQ0p6lNbaUwbRqsB-81XZtOEryEXFzB9O7A7dSQz8', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 454, '2023-12-05 10:37:39 AM', '2023-12-05 10:49:07 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc2MTg1OSwiZXhwIjoxNzAxODIxODU5fQ.fNNnmyb1UakrQFdd7aUp_7UAuQJeU3vXJ7iqGGWSStA', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 455, '2023-12-05 10:49:11 AM', '2023-12-05 11:24:43 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NjI1NTEsImV4cCI6MTcwMTgyMjU1MX0.bW5Aro_b5biFzKHqLsPOgtK_0hccysevnCTbvbUPbQ8', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 456, '2023-12-05 11:24:49 AM', '2023-12-05 11:25:11 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc2NDY4OSwiZXhwIjoxNzAxODI0Njg5fQ.6KjzHnIoSs4G87odlkngWZcZVec9knjTu--5mIATowY', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 457, '2023-12-05 11:25:17 AM', '2023-12-05 11:25:41 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc2NDcxNywiZXhwIjoxNzAxODI0NzE3fQ.6fo1qq9GiI-S-qGUi9EHzOEnvbrAEds9NCWMzhoHUBA', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 458, '2023-12-05 11:25:56 AM', '2023-12-05 11:54:18 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc2NDc1NiwiZXhwIjoxNzAxODI0NzU2fQ.TfKHggVFvEqvahCVxnoRaYxjCx_TTzE3NdPsBtGfwBI', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 459, '2023-12-05 11:54:37 AM', '2023-12-06 04:34:37 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc2NjQ3NywiZXhwIjoxNzAxODI2NDc3fQ.Vkp8pH3LJtLNczFpFPlWLHhhH4kSrAeQ52fAcNoRb68', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 460, '2023-12-05 01:36:21 PM', '2023-12-05 01:47:51 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NzI1ODEsImV4cCI6MTcwMTgzMjU4MX0.EGVXPtnlKIHdQvI3ZWfusEI_v_jVDqIf1At1pj-j1S8', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 461, '2023-12-05 01:47:58 PM', '2023-12-05 01:54:46 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc3MzI3OCwiZXhwIjoxNzAxODMzMjc4fQ.pqKlrzkG8yEWHzFwoQQ2aPR94YXh17SbtXbmJkngCxg', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 462, '2023-12-05 01:54:50 PM', '2023-12-05 01:54:54 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NzM2OTAsImV4cCI6MTcwMTgzMzY5MH0.ezjllF5ec8jLgy0hVxjKPyqLDZ7KbyoJ-kQ6CelRVLQ', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 463, '2023-12-05 01:54:58 PM', '2023-12-05 01:55:01 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NzM2OTgsImV4cCI6MTcwMTgzMzY5OH0.gywrLaX2iZs9dDcs1oA48pq5A3zym1GISMX3x4cvOTE', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 464, '2023-12-05 01:55:06 PM', '2023-12-05 02:22:53 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc3MzcwNiwiZXhwIjoxNzAxODMzNzA2fQ.m2JGmFumpKZ3AQO4R-1onwEwyqBlZW2o48pyUIavRLo', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 465, '2023-12-05 02:22:59 PM', '2023-12-05 02:34:11 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc3NTM3OSwiZXhwIjoxNzAxODM1Mzc5fQ.VITRqiessF0Ks9YZqYHUNHWcxHRKj5HA6aRtWMAtpZ8', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 466, '2023-12-05 02:34:50 PM', '2023-12-05 02:36:03 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc3NjA5MCwiZXhwIjoxNzAxODM2MDkwfQ.FWBoAzhbOTcOSlwdNbbKiwEKwUGmjOpPejgw4-ig2U8', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 467, '2023-12-05 02:36:13 PM', '2023-12-05 02:59:58 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NzYxNzMsImV4cCI6MTcwMTgzNjE3M30.bsQjuNMpfjsTvLne2Begro5jCuJ-_4n61i6-kvRLK5c', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 468, '2023-12-05 03:11:42 PM', '2023-12-06 07:51:42 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc3ODMwMiwiZXhwIjoxNzAxODM4MzAyfQ.TRlh8jcuE-KUuwJVumBsm3GBAH4ZO-TSYuuU_b3IXFQ', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 469, '2023-12-05 03:12:32 PM', '2023-12-06 07:52:32 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3NzgzNTIsImV4cCI6MTcwMTgzODM1Mn0.3NaD_R1-7WzK90YrT9qwoyGcbhoSdUCEgZh-dniwdRg', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 470, '2023-12-05 03:18:36 PM', '2023-12-06 07:58:36 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTc3ODcxNiwiZXhwIjoxNzAxODM4NzE2fQ.QncPSMLI2AfF0hamKmu_VY1l5mimB-t2GlPjfrrKT6I', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 471, '2023-12-05 03:46:10 PM', '2023-12-05 03:49:32 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE3ODAzNzAsImV4cCI6MTcwMTg0MDM3MH0.XPwJyAXJexhoO9gTJbSkRAOC26WRuyk3UIxzLJLjJYg', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 472, '2023-12-06 10:06:42 AM', '2023-12-06 10:36:33 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg0NjQwMiwiZXhwIjoxNzAxOTA2NDAyfQ.RZg3nAvrRPWl7k-q7gPZfbrOcdGmaJqr8vMyPHErbaE', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 473, '2023-12-06 10:36:38 AM', '2023-12-06 10:54:04 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NDgxOTgsImV4cCI6MTcwMTkwODE5OH0.tDLad78LqWPl0BhI1r-C-WjuzpXM0MrdK-GKo0Irwq0', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 474, '2023-12-06 10:54:10 AM', '2023-12-06 11:07:53 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg0OTI1MCwiZXhwIjoxNzAxOTA5MjUwfQ.mETD7jXhENo36hqvXQipwYEZZKbfbDJ-0FJzBXV7COg', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 476, '2023-12-06 11:07:58 AM', '2023-12-06 11:21:49 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg1MDA3OCwiZXhwIjoxNzAxOTEwMDc4fQ.KCE7NLm8Or6S9r0ny3xMQSwM39tU-umilCgiN6AbZp8', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 477, '2023-12-06 11:22:29 AM', '2023-12-06 11:40:42 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NTA5NDksImV4cCI6MTcwMTkxMDk0OX0._bRcdkjjcdep9gvKNHbATW1qpTVSwqMCUb928XbgITM', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 478, '2023-12-06 11:40:48 AM', '2023-12-06 11:56:41 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg1MjA0OCwiZXhwIjoxNzAxOTEyMDQ4fQ.4XFUHV1JDAC6cbqaZb9g-IZOzNlzsObOdDOlciSBtiE', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 479, '2023-12-06 11:56:49 AM', '2023-12-07 04:36:49 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg1MzAwOSwiZXhwIjoxNzAxOTEzMDA5fQ.UfG5UMkkora8nldVYpgn5jRHdU5xFNRvoyi1g0lmd6Q', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 480, '2023-12-06 11:57:10 AM', '2023-12-06 11:58:24 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NTMwMzAsImV4cCI6MTcwMTkxMzAzMH0.VCi2x4wrx5IPmfj5zZt7SRt7MdA3_aVIdi9Dy1dmiXo', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 481, '2023-12-06 11:58:34 AM', '2023-12-06 01:35:42 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg1MzExNCwiZXhwIjoxNzAxOTEzMTE0fQ.t8BgHLrKFQGr8Z2h0ohMaGbZUYtExyW5_ne4Mksu_DU', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 475, '2023-12-06 10:54:23 AM', '2023-12-06 02:22:01 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NDkyNjMsImV4cCI6MTcwMTkwOTI2M30.S20fhE0koWiJh8rCUVvTryv2BPjAecosvMLznFfo8Vc', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 482, '2023-12-06 01:35:48 PM', '2023-12-06 01:36:00 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NTg5NDgsImV4cCI6MTcwMTkxODk0OH0.C8Ctc6mmd0CoLOSQ56pbPipTZ9QONNZRrvoNqNejueo', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 483, '2023-12-06 01:36:20 PM', '2023-12-06 01:38:20 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NTg5ODAsImV4cCI6MTcwMTkxODk4MH0.k5s-loP3rvn75nt0pLbVFc65O80k2i2iUtF31FjgC3w', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 484, '2023-12-06 01:38:28 PM', '2023-12-07 06:18:28 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg1OTEwOCwiZXhwIjoxNzAxOTE5MTA4fQ.Zy2mOGQclMGgIOmv363P00O1oMu9quqhFxBA3iv9vZA', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 485, '2023-12-06 01:49:16 PM', '2023-12-07 06:29:16 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg1OTc1NiwiZXhwIjoxNzAxOTE5NzU2fQ.xOmLoVE3EPDU0lUbIUmckWLs9Gbfl-KIMrkYK_W6F-g', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 486, '2023-12-06 02:19:09 PM', '2023-12-06 02:36:06 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2MTU0OSwiZXhwIjoxNzAxOTIxNTQ5fQ.KqNOE-6IaKrhA1vz-uN53vatJOW1IObK4zrPeN7ioV8', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 488, '2023-12-06 02:36:26 PM', '2023-12-06 02:38:43 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NjI1ODYsImV4cCI6MTcwMTkyMjU4Nn0.8rRV6ybDrNjBkX3B73vc8lbmOYSVFLo8eXtVdkOy_do', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 489, '2023-12-06 02:38:49 PM', '2023-12-06 02:41:01 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2MjcyOSwiZXhwIjoxNzAxOTIyNzI5fQ.t3OAwLTczAzC5S1YWT0m8S1wI9ycLFwvxhcenCQPz1o', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 490, '2023-12-06 02:41:14 PM', '2023-12-06 02:58:03 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NjI4NzQsImV4cCI6MTcwMTkyMjg3NH0.8JQpFBcIuvF2aCdfm64nJMmj5CuXXueaYvLvTeJOV-A', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 487, '2023-12-06 02:22:09 PM', '2023-12-06 03:31:47 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJzc3NzIiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NjE3MjksImV4cCI6MTcwMTkyMTcyOX0.AQahMNWenLmk3yTDHJUxHQA3Ks3Vq_qsolMBIQy3Hho', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 492, '2023-12-06 03:31:58 PM', '2023-12-07 08:11:58 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2NTkxOCwiZXhwIjoxNzAxOTI1OTE4fQ.l3JbuWlf9scwmLoHzg9LaT8kte5loCCAmc0GbkFus54', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 493, '2023-12-06 03:32:48 PM', '2023-12-06 03:41:27 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2NTk2OCwiZXhwIjoxNzAxOTI1OTY4fQ.AimyxhxNcowsr-nHYvtYYwP9JgKKczp7hY2lmMmQjd0', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 494, '2023-12-06 03:41:49 PM', '2023-12-06 03:42:46 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2NjUwOSwiZXhwIjoxNzAxOTI2NTA5fQ.fvpXL56foI-q9uzsBr8Kw6rS-EYpcqkYOt6eIwoqR_0', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 491, '2023-12-06 02:58:10 PM', '2023-12-06 03:44:42 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2Mzg5MCwiZXhwIjoxNzAxOTIzODkwfQ.BhbiCwdpHzO4sWMm6pZEdA5Bzv_wOmocXBSjyHMFm54', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 495, '2023-12-06 03:42:56 PM', '2023-12-06 03:45:42 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2NjU3NiwiZXhwIjoxNzAxOTI2NTc2fQ.Tv_BcVOIKOpykpkHRKO3HentusW0dJrljCT-zZyKsAY', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 497, '2023-12-06 03:45:56 PM', '2023-12-06 03:57:34 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2Njc1NiwiZXhwIjoxNzAxOTI2NzU2fQ.-E7f3mabt6dRs4lN24hg1j8lQ3yx-BQTcCNiUth7kJI', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 496, '2023-12-06 03:45:09 PM', '2023-12-06 04:30:30 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2NjcwOSwiZXhwIjoxNzAxOTI2NzA5fQ.YG8ITs9ErA3pULzmGdyevz2Q1UpIenwgcpMk-9IY-aw', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 498, '2023-12-06 03:57:43 PM', '2023-12-06 04:47:35 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2NzQ2MywiZXhwIjoxNzAxOTI3NDYzfQ.WXB-rTJ85s029_GgKH-IalnfA4ikUMhVP_UeJ9N9_T0', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 500, '2023-12-06 04:47:46 PM', '2023-12-06 04:48:04 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3MDQ2NiwiZXhwIjoxNzAxOTMwNDY2fQ.bzH8zW9BsKXZXkrbBMZ6Seqq1HAHgenyuEl1QJTBOqw', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 501, '2023-12-06 04:48:15 PM', '2023-12-07 09:28:15 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3FkdnNkdmVlZWVlZWVlZWUiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODcwNDk1LCJleHAiOjE3MDE5MzA0OTV9.OVGBot8afPVC8IonCTUpYnmgZJu0qllF-y_y5Fd7MbM', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 499, '2023-12-06 04:31:48 PM', '2023-12-06 04:57:42 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg2OTUwOCwiZXhwIjoxNzAxOTI5NTA4fQ.qzqGyjErVaR4ZwNa-JaXuSWuDGN3JCWRd5MX7S2_KG0', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 502, '2023-12-06 04:58:02 PM', '2023-12-07 09:38:02 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiQ2Fybm90IiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NzEwODIsImV4cCI6MTcwMTkzMTA4Mn0.ta0NsUq6XA906SUAOl09Sg8mIDLDw5EiCMtXil2f_NY', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 503, '2023-12-06 04:58:07 PM', '2023-12-06 05:00:21 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3MTA4NywiZXhwIjoxNzAxOTMxMDg3fQ.HG-26UCBUDaja4TIUN5dGSE_vCANHr_zNbK-E07SuVs', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 504, '2023-12-06 05:00:28 PM', '2023-12-07 09:40:28 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoibWVkZG9jIiwiaWQiOjQ3LCJzdWIiOiJtYW5hZ2VyQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3MTIyOCwiZXhwIjoxNzAxOTMxMjI4fQ.bggbGUM2kPExtLa6uX-Q2avS88CjhPxon4KEaJ_chAM', 47);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 505, '2023-12-06 05:52:54 PM', '2023-12-07 10:32:54 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3FkdnNkdmVlZWVlZWVlZWUiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODc0Mzc0LCJleHAiOjE3MDE5MzQzNzR9.idU1s2ipw2DSK8P1iRGpOOC9Dw07lE5fNCY2LeAndTM', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 506, '2023-12-06 05:52:58 PM', '2023-12-06 05:53:11 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3NDM3OCwiZXhwIjoxNzAxOTM0Mzc4fQ.PhORlSfZJHpDcQuz9GMHw1Ah1bwUKBDFMC2839FNtx0', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 508, '2023-12-06 05:57:49 PM', '2023-12-07 10:37:49 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoiQ2Fybm90IiwiaWQiOjQyLCJzdWIiOiJoYWphaW5hMjI2NUBnbWFpbC5jb20iLCJpYXQiOjE3MDE4NzQ2NjksImV4cCI6MTcwMTkzNDY2OX0.A4QgqS0QscdG_0858qUgNz4CY8_r7qIcCTUDVgpPVus', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 507, '2023-12-06 05:53:16 PM', '2023-12-06 06:02:14 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3NDM5NiwiZXhwIjoxNzAxOTM0Mzk2fQ.CD4UWiKpnCd_LxEQlArsl_vF1aoaIdiDxkCD-hp8_Jk', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 509, '2023-12-06 05:57:59 PM', '2023-12-06 06:02:15 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3NDY3OSwiZXhwIjoxNzAxOTM0Njc5fQ.nDgHfsu6zjYDHrl6KB4K_wQD403LJikhafaFa7BtzYs', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 511, '2023-12-06 06:02:39 PM', '2023-12-07 10:42:39 AM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3NDk1OSwiZXhwIjoxNzAxOTM0OTU5fQ.Moj9lRfm7HI57EfPbdLYBxtge0NzNwHNBJ17vLGOXRg', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 510, '2023-12-06 06:02:20 PM', '2023-12-06 06:02:47 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3NDk0MCwiZXhwIjoxNzAxOTM0OTQwfQ.ITeoxmLjHG5HAk6EgXPRvLLllntzbU-Hs3oJo94XxZA', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 512, '2023-12-06 06:03:00 PM', '2023-12-06 07:22:25 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNxZHZzZHZlZWVlZWVlZWVlIiwiaWQiOjQ1LCJzdWIiOiJwYXBhQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3NDk4MCwiZXhwIjoxNzAxOTM0OTgwfQ.Mu2PhC158CrzcWuhil1G5NkU_cGs8VqVe_ObgLJTi7g', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 513, '2023-12-06 07:25:41 PM', '2023-12-07 12:05:41 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg3OTk0MSwiZXhwIjoxNzAxOTM5OTQxfQ.PgNMrcrBAc_1Lo7-6o-FqfxKqdJq8KPs_JfsguWfDfI', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 514, '2023-12-06 07:32:36 PM', '2023-12-06 07:35:18 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODgwMzU2LCJleHAiOjE3MDE5NDAzNTZ9.faiUDz4vWdPPPUhw-IdIVPPNyI9dc4Bwjcidlb72Jlk', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 515, '2023-12-06 07:35:26 PM', '2023-12-06 07:43:22 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg4MDUyNiwiZXhwIjoxNzAxOTQwNTI2fQ.fYvnr4WzHQ7ZzJAdZj_IvwutoFmSYTXZtFInIUOdbX4', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 516, '2023-12-06 07:43:33 PM', '2023-12-06 07:48:46 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODgxMDEzLCJleHAiOjE3MDE5NDEwMTN9.FgZwA8a_EmocrNu667W06YHTZ6CKieibYey6pcEPMoY', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 517, '2023-12-06 07:48:57 PM', '2023-12-07 12:28:57 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg4MTMzNywiZXhwIjoxNzAxOTQxMzM3fQ.LUswYdE8Xa8MSmKJpTAZiQ59S5vNb7yKn49XCXbBEIg', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 518, '2023-12-06 07:59:09 PM', '2023-12-06 07:59:29 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg4MTk0OSwiZXhwIjoxNzAxOTQxOTQ5fQ.RtqQtSUqFzp9oyq9P8zTvk36CW_OoFdvuAoZrdNxFn8', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 520, '2023-12-06 08:00:41 PM', '2023-12-07 12:40:41 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODgyMDQxLCJleHAiOjE3MDE5NDIwNDF9.HMjcwxs66UKSezt9XXA21aAYEpSl-h_j3qcZXfzXjWQ', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 519, '2023-12-06 07:59:38 PM', '2023-12-06 09:32:30 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODgxOTc4LCJleHAiOjE3MDE5NDE5Nzh9.Y1aDIDBtMD3so91DmgdhfEvxG2_RuJskWH94nmdoJSE', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 521, '2023-12-06 08:11:42 PM', '2023-12-06 09:37:01 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhcGFAZ21haWwuY29tIiwiaWF0IjoxNzAxODgyNzAyLCJleHAiOjE3MDE5NDI3MDJ9.2AEGYPZlhzF42MMc_7NBe3fNkRxBtGLSZZmVFh1SIYw', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 522, '2023-12-06 09:41:18 PM', '2023-12-06 10:29:42 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg4ODA3OCwiZXhwIjoxNzAxOTQ4MDc4fQ.E3vdq1LgIb_mYPOxTBRS14L8nWZe1S3QcLCkBhuFX48', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 523, '2023-12-06 10:29:52 PM', '2023-12-06 10:42:29 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhdWxtYXVyaWNlQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MDk5MiwiZXhwIjoxNzAxOTUwOTkyfQ.m1U3X9dTK0GATomm6OzNlbrhsPZqK_wAIb3BcGPqLOs', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 524, '2023-12-06 10:42:58 PM', '2023-12-07 03:22:58 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic3NzcyIsImlkIjo0NCwic3ViIjoiamVhbmx1aXNAZ21haWwuY29tIiwiaWF0IjoxNzAxODkxNzc4LCJleHAiOjE3MDE5NTE3Nzh9.0au84LRF7VYC908Dfbm3ffAnqNxBQI0lmj4jocGTIl8', 44);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 525, '2023-12-06 10:43:20 PM', '2023-12-06 10:43:34 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MTgwMCwiZXhwIjoxNzAxOTUxODAwfQ.OkHOy-ufZ6KDJ3Z-WW0mIRy6F-qxOBYTHDYBQS-5IOI', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 526, '2023-12-06 10:43:40 PM', '2023-12-06 10:44:36 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNzc3MiLCJpZCI6NDQsInN1YiI6ImplYW5sdWlzQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MTgyMCwiZXhwIjoxNzAxOTUxODIwfQ.ZB-Vqjvp00gKVvXSVUHygGRMkI3ixD_e-DMeufTAWZY', 44);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 527, '2023-12-06 10:45:03 PM', '2023-12-06 10:45:19 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhdWxtYXVyaWNlQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MTkwMywiZXhwIjoxNzAxOTUxOTAzfQ.tortPR519WLWpZ4cyVDIa3OeGBqNteqPPsf67Xk13Bc', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 528, '2023-12-06 10:45:29 PM', '2023-12-06 10:47:39 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6InNzc3MiLCJpZCI6NDQsInN1YiI6ImplYW5sdWlzQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MTkyOSwiZXhwIjoxNzAxOTUxOTI5fQ.knKFQd6TRJGRcWRKinL311BNKy0Xyt5BpNmcOpyThL8', 44);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 529, '2023-12-06 10:48:00 PM', '2023-12-06 10:48:16 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MjA4MCwiZXhwIjoxNzAxOTUyMDgwfQ.8xE37NIW6CwSquZaDnMnxHYk_H5nwZrTovBj6Z0jwu8', 67);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 530, '2023-12-06 10:48:25 PM', '2023-12-07 03:28:25 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6ImRxc2Rxc2RkIiwiaWQiOjY5LCJzdWIiOiJ2ZWxvbWFuYW5hQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MjEwNSwiZXhwIjoxNzAxOTUyMTA1fQ.kJP0ScMLIpapo7HLKGtvqm3GMvqxyuXS_EqqXCCIOhc', 69);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 531, '2023-12-06 10:49:07 PM', '2023-12-06 10:49:13 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhdWxtYXVyaWNlQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MjE0NywiZXhwIjoxNzAxOTUyMTQ3fQ.KxNmwIdwi_LWu_aLRGUaFNNvfaR-P1XP44VSdy6Qvgc', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 532, '2023-12-06 10:49:19 PM', '2023-12-06 10:53:48 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IkplYW4iLCJpZCI6NDQsInN1YiI6ImplYW5sdWlzQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MjE1OSwiZXhwIjoxNzAxOTUyMTU5fQ.5Gj50tV5r6tqSlnQutTyChiXaKewtzf81V7krgOvkYE', 44);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 533, '2023-12-06 10:53:54 PM', '2023-12-06 10:55:08 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhdWxtYXVyaWNlQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MjQzNCwiZXhwIjoxNzAxOTUyNDM0fQ.peqKCXvhc2jVKkitI549WP64qesqEcRop0RW9MbCUTU', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 534, '2023-12-06 10:55:18 PM', '2023-12-06 11:12:43 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IkplYW4iLCJpZCI6NDQsInN1YiI6ImplYW5sdWlzQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MjUxOCwiZXhwIjoxNzAxOTUyNTE4fQ.iRikobJu7M9fIzx6nvo11z_ZXzbAqnwTzdH67j7JOyg', 44);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 535, '2023-12-06 11:13:10 PM', '2023-12-06 11:15:14 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6IlBhdWwiLCJpZCI6NDUsInN1YiI6InBhdWxtYXVyaWNlQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MzU5MCwiZXhwIjoxNzAxOTUzNTkwfQ.LODjEj5ryBzP9LY-yncZgyd9wZGqNeTqTUd_zfJWMEU', 45);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 536, '2023-12-06 11:15:20 PM', '2023-12-06 11:24:03 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6ImRxc2Rxc2RkIiwiaWQiOjY5LCJzdWIiOiJ2ZWxvbWFuYW5hQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5MzcyMCwiZXhwIjoxNzAxOTUzNzIwfQ.wHVBuDSx_2V-7E1Z3hNwW_RSi0uAWZod2yyHZhn3G_Q', 69);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 537, '2023-12-06 11:24:14 PM', '2023-12-06 11:25:35 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiaGVhbHRocHJvIiwibmFtZSI6ImRxc2Rxc2RkIiwiaWQiOjY5LCJzdWIiOiJ2ZWxvbWFuYW5hQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5NDI1NCwiZXhwIjoxNzAxOTU0MjU0fQ.iNK6IpUkDalPAxom2I-nHo4BZdwAV-SL3j-VSb9q6Lc', 69);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 538, '2023-12-06 11:26:25 PM', '2023-12-06 11:37:06 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoicGF0aWVudCIsIm5hbWUiOiJDYXJub3QiLCJpZCI6NDIsInN1YiI6ImhhamFpbmEyMjY1QGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5NDM4NSwiZXhwIjoxNzAxOTU0Mzg1fQ.26msyazzglifHllnvnZrgM2WxEf0-dC0p6LNmdT7pCw', 42);
INSERT INTO "public".jwt( id, created_at, expires_at, token, user_id ) VALUES ( 539, '2023-12-06 11:37:24 PM', '2023-12-07 04:17:24 PM', 'eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiYWRtaW4iLCJuYW1lIjoiYWRtaW4iLCJpZCI6NjcsInN1YiI6ImFkbWluQGdtYWlsLmNvbSIsImlhdCI6MTcwMTg5NTA0NCwiZXhwIjoxNzAxOTU1MDQ0fQ.eddw5eTLtaelpuRcI9kw5PxYHbrHGqTC7unzLUQAvcI', 67);
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 31, ' Votre rendez-vous le  Mardi 05 Décembre  2023 17:17 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est annulé ', 42, null, '2023-12-05 11:55:24 AM', '2023-12-05 01:42:03 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 29, ' Votre rendez-vous le  Mardi 05 Décembre  2023 16:44 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est annulé ', 42, null, '2023-12-05 11:53:55 AM', '2023-12-05 01:43:10 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 30, 'Vous avez un nouveau  rendez-vous le   Mardi 05 Décembre  2023 17:17 au  nom de  haha  ssss', 45, null, '2023-12-05 11:55:04 AM', '2023-12-05 01:48:05 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 28, 'Vous avez un nouveau  rendez-vous le   Mardi 05 Décembre  2023 16:44 au  nom de  haha  ssss', 45, null, '2023-12-05 11:53:24 AM', '2023-12-05 01:48:06 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 27, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 01:57 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:45:19 AM', '2023-12-05 01:48:07 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 26, ' Votre rendez-vous le  Mardi 05 Décembre  2023 16:11 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:41:27 AM', '2023-12-05 01:48:08 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 25, 'Vous avez un nouveau  rendez-vous le   Mardi 05 Décembre  2023 16:11 au  nom de  haha  ssss', 45, null, '2023-12-05 11:41:07 AM', '2023-12-05 01:48:08 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 24, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 02:30 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:40:48 AM', '2023-12-05 01:48:09 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 23, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:03 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:40:24 AM', '2023-12-05 01:48:09 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 22, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:36 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:38:42 AM', '2023-12-05 01:48:09 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 21, ' Votre rendez-vous le  Mardi 05 Décembre  2023 17:17 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:38:29 AM', '2023-12-05 01:48:10 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 20, ' Votre rendez-vous le  Mardi 05 Décembre  2023 16:44 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:38:18 AM', '2023-12-05 01:48:10 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 19, ' Votre rendez-vous le  Mardi 05 Décembre  2023 16:11 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:37:59 AM', '2023-12-05 01:48:11 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 18, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:36 au  nom de  haha  ssss', 45, null, '2023-12-05 11:37:13 AM', '2023-12-05 01:48:11 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 17, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:03 au  nom de  haha  ssss', 45, null, '2023-12-05 11:36:38 AM', '2023-12-05 01:48:12 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 16, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 02:30 au  nom de  haha  ssss', 45, null, '2023-12-05 11:34:46 AM', '2023-12-05 01:48:12 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 15, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 01:57 au  nom de  haha  ssss', 45, null, '2023-12-05 11:33:56 AM', '2023-12-05 01:48:13 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 14, 'Vous avez un nouveau  rendez-vous le   Mardi 05 Décembre  2023 16:44 au  nom de  haha  ssss', 45, null, '2023-12-05 11:27:49 AM', '2023-12-05 01:48:13 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 13, 'Vous avez un nouveau  rendez-vous le   Mardi 05 Décembre  2023 16:11 au  nom de  haha  ssss', 45, null, '2023-12-05 11:24:33 AM', '2023-12-05 01:48:14 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 12, ' Votre rendez-vous le  Mardi 05 Décembre  2023 16:11 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 11:17:53 AM', '2023-12-05 01:48:14 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 11, ' Votre rendez-vous le  Mardi 05 Décembre  2023 16:11 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 10:38:07 AM', '2023-12-05 01:48:15 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 10, ' Votre rendez-vous le  Mardi 05 Décembre  2023 02:30 au nom de haha  ssss  est annulé ', 45, null, '2023-12-04 11:49:02 AM', '2023-12-05 01:48:16 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 9, ' Votre rendez-vous le  Mardi 05 Décembre  2023 01:57 au nom de haha  ssss  est annulé ', 45, null, '2023-12-04 11:18:57 AM', '2023-12-05 01:48:16 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 33, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:36 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 01:49:34 PM', '2023-12-05 01:51:37 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 32, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:36 au  nom de  haha  ssss', 45, null, '2023-12-05 01:49:12 PM', '2023-12-05 01:51:38 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 59, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 14:58 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 11:21:08 AM', '2023-12-06 11:21:30 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 34, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 02:30 au  nom de  haha  ssss', 45, null, '2023-12-05 01:51:56 PM', '2023-12-05 01:52:59 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 35, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:03 au  nom de  haha  ssss', 45, null, '2023-12-05 01:53:57 PM', '2023-12-05 01:54:09 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 37, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:03 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 01:55:45 PM', '2023-12-05 01:56:13 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 36, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 02:30 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 01:54:21 PM', '2023-12-05 01:56:14 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 38, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 02:30 au  nom de  haha  ssss', 45, null, '2023-12-05 01:57:13 PM', '2023-12-05 01:58:13 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 39, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:03 au  nom de  haha  ssss', 45, null, '2023-12-05 01:58:38 PM', '2023-12-05 01:58:55 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 40, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:36 au  nom de  haha  ssss', 45, null, '2023-12-05 01:59:16 PM', '2023-12-05 02:00:52 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 41, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:36 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:00:08 PM', '2023-12-05 02:01:22 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 42, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:03 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:01:36 PM', '2023-12-05 02:02:28 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 43, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 02:30 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:02:20 PM', '2023-12-05 02:02:30 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 44, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 02:30 au  nom de  haha  ssss', 45, null, '2023-12-05 02:02:59 PM', '2023-12-05 02:05:31 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 45, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 03:03 au  nom de  haha  ssss', 45, null, '2023-12-05 02:05:55 PM', '2023-12-05 02:07:38 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 46, 'Vous avez un nouveau  rendez-vous le   Jeudi 07 Décembre  2023 14:58 au  nom de  haha  ssss', 45, null, '2023-12-05 02:08:01 PM', '2023-12-05 02:08:41 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 49, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 03:03 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:09:17 PM', '2023-12-05 02:09:26 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 48, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 02:30 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:08:58 PM', '2023-12-05 02:09:27 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 47, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 14:58 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:08:47 PM', '2023-12-05 02:09:28 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 50, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 02:30 au  nom de  haha  ssss', 45, null, '2023-12-05 02:09:52 PM', '2023-12-05 02:09:56 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 51, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 02:30 au nom de haha  ssss  est annulé ', 45, null, '2023-12-05 02:10:12 PM', '2023-12-05 02:10:45 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 53, 'Le résultat  de votre consultation le  Mardi 05 Décembre  2023 16:11 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt est disponible ', 42, null, '2023-12-05 03:45:00 PM', '2023-12-05 03:46:23 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 54, 'Le résultat  de votre consultation le  Mardi 05 Décembre  2023 16:11 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt est disponible ', 42, null, '2023-12-05 03:45:13 PM', '2023-12-05 03:46:30 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 55, 'Le résultat  de votre consultation le  Mardi 05 Décembre  2023 16:44 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt est disponible ', 42, null, '2023-12-05 03:46:48 PM', '2023-12-05 03:47:00 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 52, 'Vous avez un nouveau  rendez-vous le   Jeudi 07 Décembre  2023 14:58 au  nom de  haha  ssss', 45, null, '2023-12-05 03:12:54 PM', '2023-12-06 10:16:45 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 57, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 14:58 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 03:00:00 PM', '2023-12-06 11:21:33 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 56, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 14:58 au  nom de  haha  ssss', 45, null, '2023-12-06 10:54:53 AM', '2023-12-06 11:40:58 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 64, ' Votre rendez-vous le  Mercredi 06 Décembre  2023 14:58 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 11:50:29 AM', '2023-12-06 11:50:39 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 61, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 10:00 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 11:44:16 AM', '2023-12-06 11:50:40 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 60, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 10:33 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 11:44:16 AM', '2023-12-06 11:50:41 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 67, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 14:58 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 11:52:25 AM', '2023-12-06 11:52:38 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 68, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 10:00 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 11:52:25 AM', '2023-12-06 11:52:40 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 65, 'Vous avez un nouveau  rendez-vous le   Jeudi 07 Décembre  2023 14:58 au  nom de  haha  ssss', 45, null, '2023-12-06 11:50:57 AM', '2023-12-06 11:56:27 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 66, 'Vous avez un nouveau  rendez-vous le   Jeudi 07 Décembre  2023 10:00 au  nom de  haha  ssss', 45, null, '2023-12-06 11:51:46 AM', '2023-12-06 11:56:28 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 69, 'Vous avez un nouveau  rendez-vous le   Vendredi 08 Décembre  2023 12:33 au  nom de  haha  ssss', 45, null, '2023-12-06 11:53:05 AM', '2023-12-06 11:56:29 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 70, 'Vous avez un nouveau  rendez-vous le   Vendredi 08 Décembre  2023 13:06 au  nom de  haha  ssss', 45, null, '2023-12-06 11:54:19 AM', '2023-12-06 11:56:31 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 71, ' Votre rendez-vous le  Vendredi 08 Décembre  2023 13:06 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est annulé ', 42, null, '2023-12-06 11:54:40 AM', '2023-12-06 11:57:00 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 72, ' Votre rendez-vous le  Vendredi 08 Décembre  2023 12:33 au nom de haha  ssss  avec  sqdvsdveeeeeeeeee  tttttttt  est annulé ', 42, null, '2023-12-06 11:54:56 AM', '2023-12-06 11:57:02 AM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 73, ' Votre rendez-vous le  Vendredi 08 Décembre  2023 12:00 au nom de Jean  Carnot  est annulé ', 45, null, '2023-12-06 03:42:06 PM', '2023-12-06 04:07:04 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 75, 'Vous avez un nouveau  rendez-vous le   Vendredi 08 Décembre  2023 12:00 au  nom de  Jean  Carnot', 45, null, '2023-12-06 04:06:25 PM', '2023-12-06 05:53:58 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 77, 'Vous avez un nouveau  rendez-vous le   Jeudi 07 Décembre  2023 14:58 au  nom de  Jean  Carnot', 45, null, '2023-12-06 04:13:12 PM', '2023-12-06 05:53:58 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 79, 'Vous avez un nouveau  rendez-vous le   Vendredi 08 Décembre  2023 13:39 au  nom de  Jean  Carnot', 45, null, '2023-12-06 04:15:41 PM', '2023-12-06 05:53:59 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 80, 'Vous avez un nouveau  rendez-vous le   Vendredi 08 Décembre  2023 14:12 au  nom de  Jean  Carnot', 45, null, '2023-12-06 04:28:47 PM', '2023-12-06 05:53:59 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 74, 'Vous avez manqué le  rendez-vous du   Mardi 05 Décembre  2023 17:17 au nom de Jean  Carnot  avec  sqdvsdveeeeeeeeee  tttttttt', 42, null, '2023-12-06 04:01:53 PM', '2023-12-06 06:02:46 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 76, ' Votre rendez-vous le  Vendredi 08 Décembre  2023 12:00 au nom de Jean  Carnot  avec  sqdvsdveeeeeeeeee  tttttttt  est annulé ', 42, null, '2023-12-06 04:11:16 PM', '2023-12-06 06:02:48 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 78, ' Votre rendez-vous le  Jeudi 07 Décembre  2023 14:58 au nom de Jean  Carnot  avec  sqdvsdveeeeeeeeee  tttttttt  est reporté ', 42, null, '2023-12-06 04:14:30 PM', '2023-12-06 06:02:49 PM');
INSERT INTO "public".notification( id, message, user_id, "type", created_at, seen_at ) VALUES ( 81, 'Vous avez un nouveau  rendez-vous le   Mercredi 06 Décembre  2023 18:43 au  nom de  Jean  Carnot', 45, null, '2023-12-06 06:04:53 PM', '2023-12-06 06:05:03 PM');
INSERT INTO "public".otpvalidation( id, user_id, digit_code, created_at, expires_at, "value" ) VALUES ( 6, 73, '622901', '2023-11-17 04:36:57 PM', '2023-11-17 04:46:57 PM', null);
INSERT INTO "public".otpvalidation( id, user_id, digit_code, created_at, expires_at, "value" ) VALUES ( 8, 75, '937061', '2023-11-17 04:47:56 PM', '2023-11-17 04:57:56 PM', null);
INSERT INTO "public".otpvalidation( id, user_id, digit_code, created_at, expires_at, "value" ) VALUES ( 9, 79, '772483', '2023-11-21 01:42:47 PM', '2023-11-21 01:52:47 PM', null);
INSERT INTO "public".otpvalidation( id, user_id, digit_code, created_at, expires_at, "value" ) VALUES ( 10, 80, '742707', '2023-11-21 01:50:54 PM', '2023-11-21 02:00:54 PM', null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 83, '2004-04-10', null, 'Milla Jonniah', 't', 'XY-83', 'Ratovoson', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 85, '2004-04-10', null, 'Milla Jonniah', 't', 'XY-85', 'Ratovoson', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 86, '0001-04-10', null, 'mi', 't', 'XY-86', 'ra', 75, 3);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 87, '0011-01-10', null, 'mimi', 't', 'XY-87', 'ra', 75, 2);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 88, '2023-11-11', null, 'Junior', 't', 'XY-88', 'Ryuzaki', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 89, '2023-11-10', null, 'Junior', 't', 'XY-89', 'Ryuzaki', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 62, '2005-01-13', null, 'hajaina', 't', 'XY-62', 'Ralaza', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 91, '2000-11-12', null, 'Poppins', 'f', 'XY-91', 'Marie', 42, 5);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 79, '1985-11-10', null, 'Paul', 't', 'XY-79', 'Jean', 42, 8);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 92, '2001-01-06', null, 'Linnot', 't', 'XX-92', 'Rakoto', 42, 4);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 90, '2023-11-21', null, 'Junior', 't', 'XY-90', 'Bob', 42, 4);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 80, '2023-11-09', null, 'Jeanne', 'f', 'XX-80', 'Marie', 42, 10);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 54, '2023-10-25', null, 'ssss', 't', 'XY-54', 'haja', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 56, '2023-10-25', null, 'ssss', 't', 'XY-56', 'haja', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 58, '2023-10-25', null, 'ssss', 't', 'XY-58', 'haja', null, null);
INSERT INTO "public".patient( id, birthdate, contact, firstname, gender, identifier, name, caretaker_id, relationship_id ) VALUES ( 61, '2023-10-24', null, 'aina', 't', 'XY-61', 'haja', null, null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 67, 'admin@gmail.com', '$2a$10$4BY1Le6JVCAZzjUo.iVgGeXWa1ByDrtdaaz1qBcpVllWY5oY/YqV6', 1, null, 104, '1111111111', null, null, 'admin', '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 69, 'velomanana@gmail.com', '$2a$10$XqLk0Vyxf4oki8YsJ.nxsuGmhQjkDVl/mNgxIr53a0aBWsxekUj.O', 3, null, 106, '0341560020', null, null, 'Fianarantsoa Tanambao', '2023-12-06 11:49:20 PM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 53, 'mama@gmail.com', '$2a$10$tam.EuzT6qyQOrNW/KD4FeCuABff7evZUpRCykdHrbPg09UCMckcW', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 55, 'mama1@gmail.com', '$2a$10$7uZaA620viYaEeMtCE87b.mlX/LN6enQvD/bJlEUjns6Jf2S27z0S', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 56, 'mama2@gmail.com', '$2a$10$vHB/83p0uDCWB8OjYaGqKubH9RrtPfy6KPh.nQbk6MDzv7nfihStW', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 57, 'mama0@gmail.com', '$2a$10$YRllOcJPdirmG.P2QGmp/.t0AqxdcabsnWyntUted.gKo/wVV8V3K', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 60, 'mama3@gmail.com', '$2a$10$KejVb3knlW9cANhmlMGpteknD19cwUX/IYWKcJSgQw6lWNBgEJ6a.', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 61, 'mama4@gmail.com', '$2a$10$/VhNuAynbouTLGztveEq9.lTnnKxMtWbEn2Thd1ifgwF28y8F/jGW', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 62, 'mama5@gmail.com', '$2a$10$9XvEgbnH4vIpICCphGGJB.nkkFSayg1fS1i5UuJo/EGDs/asD30uu', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 47, 'manager@gmail.com', '$2a$10$ij6lbY3GpVoKS6qnazBAj.OOl5t3SwScBmj6xYkBMxXEwmDduvLqu', null, null, null, '1111111111', 45, null, 'sssss', '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 49, 'timk@gmail.com', '$2a$10$LaIiVZO/uUt9nLfoH3N.8.L5TwyFTDccJu5K8L6PV.j7cQdml.H.C', null, null, null, '1111111111', 46, null, 'sdqsd', '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 46, 'meddoc@gmail.com', '$2a$10$VhXZzrMWMEEWPo8zqGkDROjeNFlINszk6tp0vL8kI2TkhlKwd/WQC', null, null, null, '1111111111', 44, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 44, 'jeanluis@gmail.com', '$2a$10$lbN6.2FEPXh6YTyD9ZxoLuZGgBkPlD1o.c1nmzYk/vho8ZaprnHmq', 3, null, 87, '0331164512', null, null, 'Antananarivo Amplefiloha', '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 45, 'paulmaurice@gmail.com', '$2a$10$KYwnYP9uNyjkc540vrrFC.mDnIE6oneONsiSA8PqRJg078X.spjoG', 3, null, 88, '0321865510', null, null, 'Antananarivo Tanjombato', '2023-11-09 10:10:06 AM', '45_1700703912752.png');
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 42, 'hajaina2265@gmail.com', '$2a$10$.EUFT4AADTGryv7XMbD/w.j0/gTJpdW/bHYn2ghyY5grAH8Edg3gG', 2, 62, null, '0342680218', null, null, null, '2023-11-09 10:10:06 AM', '42_1700655884777.png');
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 50, 'rimk1@gmail.com', '$2a$10$Jp4GQQlkR72vbkIes41AaeKwlkaUbfQQ2f7CxgR80yWZNWCK/eHPK', null, null, null, '1111111111', null, null, null, '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 52, 'bij@gmail.com', '$2a$10$4Or01E8DSuGelSom22mEG.phKDOTHI0vjbShkqcS8M2./KnRwIjiS', null, null, null, '1111111111', 47, null, 'qsdqsdqs', '2023-11-09 10:10:06 AM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 73, 'jonny@gmail.com', '$2a$10$581RLirJhqbWZv4B4G38muNP0uCV3XI5A8uB.C09pkj6PyZfQw0sa', null, 83, null, '0346301772', null, null, null, null, null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 79, 'saidalighaleb007@gmail.cm', '$2a$10$bmUykQsGm2bdo/7DF39vV.dx80ePsgBFDf1MV1kaw5D2BuzRlYJgu', null, 88, null, '0325265825', null, null, null, null, null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 80, 'saidalighaleb007@gmail.com', '$2a$10$3z.94o2l99Xbb2Ag5zhuQ.Qy5soF0YTcHnZoPezaDeQiDKVFKJsp6', null, 89, null, '0323986963', null, null, null, null, null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 75, 'rmillajonniah@gmail.com', '$2a$10$sqNBSYi59cA2RYNRlVraZ.abLd3RD8wwTfyjviqTkjYUnW2Ys.oSS', null, 85, null, '0346301772', null, null, null, null, null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 81, 'zakaarisoa@gmail.com', '$2a$10$1rY6IYqaQs5zS0ggI0JZ1exl0m8Lk2YmiotL3S1Zr/pCW7fcAOuX.', 3, null, 113, '0325698852', null, null, '67', '2023-12-06 11:46:38 PM', null);
INSERT INTO "public".useraccount( id, email, "password", role_id, patient_id, healthpro_id, contact, company_id, commune_id, address, created_at, profile_picture_url ) VALUES ( 78, 'razafymahefa@gmail.com', '$2a$10$TRdAEdIFLbaiyaKtx.mA5.kHu7unqdLW/K70PF142H5iC6V.Qmk0G', null, null, 112, '0346301772', null, null, 'Lot 03-616D Soatsilefy', '2023-12-06 11:47:05 PM', null);
