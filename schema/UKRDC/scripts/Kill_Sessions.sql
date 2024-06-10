select pg_terminate_backend(pid) from pg_stat_activity where datname='JTRACE';
select pg_terminate_backend(pid) from pg_stat_activity where datname='UKRDC3';