DROP TABLE users;
DROP TABLE events;
DROP TABLE flyers;
DROP TABLE upcoming_events;
DROP TABLE event_requests;
DROP TABLE newsletter_requests;
DROP TABLE gallery_images;
DROP TABLE galleries;
DROP TABLE groups;
DROP TABLE user_groups;
DROP TABLE social_media_accounts;
DROP TABLE music_files;
DROP TABLE affiliates;
DROP TABLE contact_requests;
DROP TABLE gallery_logos;

CREATE TABLE users (
   id         integer not null auto_increment primary key,
   firstname  varchar(255),
   lastname  varchar(255),
   email     varchar(255),
   phone     varchar(10),
   birthday  varchar(8),
   is_admin_user boolean,
   crypted_password varchar(255),
   password_salt varchar(255),
   persistence_token varchar(255),
   login_count integer,
   failed_login_count integer,
   current_login_at datetime,
   last_login_at datetime,
   current_login_ip varchar(100),
   last_login_ip varchar(100),
   created_at timestamp default '0000-00-00 00:00:00',
   updated_at timestamp default now() on update now());

create table events(
   id                       integer not null auto_increment primary key,
   flyer_id		    integer,
   event_venue              varchar(50),
   event_venue_styles       varchar(50),
   event_name               varchar(100),
   event_name_styles        varchar(50),
   event_start_time         time,
   event_start_time_styles  varchar(50),
   event_start_date         date,
   event_start_date_styles  varchar(50),
   event_address            varchar(50),
   event_address_styles     varchar(50),
   event_notes1_label       varchar(50),
   event_notes1             varchar(50),
   event_notes1_styles      varchar(50),
   event_notes2_label       varchar(50),
   event_notes2             varchar(50),
   event_notes2_styles      varchar(50),
   event_notes3_label       varchar(50),
   event_notes3             varchar(50),
   event_notes3_styles      varchar(50),
   created_at timestamp     default '0000-00-00 00:00:00',
   updated_at timestamp     default now() on update now());

create table flyers (
   id		integer not null auto_increment primary key,
   filename	varchar(100),
   file_path	varchar(255),
   created_at	timestamp default '0000-00-00 00:00:00',
   updated_at	timestamp default now() on update now());

CREATE TABLE upcoming_events (
   id		integer not null auto_increment primary key,
   event_id	integer references events(id),
   event_type	varchar(1) not null,
   event_order  integer,
   created_at 	timestamp default '0000-00-00 00:00:00',
   updated_at 	timestamp default now() on update now());

create table newsletter_requests(
   id         	integer not null auto_increment primary key,
   user_id	integer references users(id),
   created_at 	timestamp default '0000-00-00 00:00:00',
   updated_at 	timestamp default now() on update now());

create table gallery_images (
   id                 integer not null auto_increment primary key,
   gallery_id         integer not null references galleries(id),
   image_path         varchar(255) not null,
   image_filename     varchar(255) not null,
   image_comments     varchar(100),
   is_slideshow_image boolean not null default false,
   is_media_image     boolean default false,
   created_at         timestamp default '0000-00-00 00:00:00',
   updated_at         timestamp default now() on update now());

create table galleries (
   id                   integer not null auto_increment primary key,
   name			varchar(255),
   description_short    varchar(255),
   description_long     varchar(1024),
   event_id	        integer,
   gallery_path         varchar(255),
   gallery_logo_id      integer,
   is_current_slideshow boolean not null default false,
   is_feature_gallery   boolean not null default false,
   is_live              boolean not null default false,
   created_at           timestamp default '0000-00-00 00:00:00',
   updated_at           timestamp default now() on update now());

CREATE TABLE groups (
   id         integer not null auto_increment primary key,
   name       varchar(255),
   group_key        varchar(100),
   created_at timestamp default '0000-00-00 00:00:00',
   updated_at timestamp default now() on update now());

CREATE TABLE user_groups(
   id         integer not null auto_increment primary key,
   user_id    integer references users(id),
   group_id   integer references groups(id),
   created_at timestamp default '0000-00-00 00:00:00',
   updated_at timestamp default now() on update now());

INSERT INTO groups (name, group_key) VALUES ('Root', 'root');
INSERT INTO groups (name, group_key) VALUES ('Photographer', 'photographer');
INSERT INTO groups (name, group_key) VALUES ('Promoter', 'promoter');

create table social_media_accounts (
   id          integer not null auto_increment primary key,
   media_name  varchar(255),
   media_url   varchar(2000),
   created_at  timestamp default '0000-00-00 00:00:00',
   updated_at  timestamp default now() on update now());

CREATE TABLE music_files (
   id           integer not null auto_increment primary key,
   filename     varchar(100),
   file_path	varchar(255),
   is_active  	boolean default false,
   created_at	timestamp default '0000-00-00 00:00:00',
   updated_at	timestamp default now() on update now());

CREATE TABLE affiliates (
   id              integer not null auto_increment primary key,
   affiliate_name  varchar(255),
   img_filename	   varchar(100),
   img_file_path   varchar(255),
   is_active       boolean default false,
   created_at	   timestamp default '0000-00-00 00:00:00',
   updated_at	   timestamp default now() on update now());

create table event_requests (
   id                       integer not null auto_increment primary key,
   user_id                  integer,
   event_date_requested	    date,
   event_for                varchar(100),
   number_of_ladies         integer,
   number_of_men            integer,
   bottle_service           varchar(100),
   city                     varchar(100),
   neighborhood             varchar(100),
   preferred_venue     	    varchar(100),
   comments                 text,
   has_contacted            boolean not null default false,
   contacted_by             varchar(100),
   event_id                 integer,
   created_at timestamp     default '0000-00-00 00:00:00',
   updated_at timestamp     default now() on update now());

create table contact_requests (
   id                       integer not null auto_increment primary key,
   user_id                  integer,
   has_contacted	           boolean not null default false,
   contacted_by             varchar(100),
   comments                 text,
   created_at timestamp     default '0000-00-00 00:00:00',
   updated_at timestamp     default now() on update now());

create table gallery_logos (
   id                   integer not null auto_increment primary key,
   logo_path            varchar(255),
   logo_file_name       varchar(255),
   created_at           timestamp default '0000-00-00 00:00:00',
   updated_at           timestamp default now() on update now());
