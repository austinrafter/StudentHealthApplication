create database if not exists studyhabits;

drop user 'root'@'%';

create user 'root'@'%' identified by 'password';

grant all on studyhabits.* to 'root'@'%';

use studyhabits;
