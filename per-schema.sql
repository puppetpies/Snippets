-- MonetDB Per schema notes

create user brian with password ’brian123' name ’brian' schema sys;
create schema schema1 AUTHORIZATION brian;
create schema schema2 AUTHORIZATION brian;

