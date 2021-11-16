# pg_jsonb
Support files for PostgreSQL JSONB presentation

# Follow along
First add the following extensions to VS Code if you don't already have them
- Database Client
- Python

Grab the test data here:
https://github.com/awksedgreep/pg_chinook
```
createdb chinook
psql chinook < Chinook_PostgreSql_SerialPKs_CaseInsensitive_CaseFixed.sql > errors.out
```

Optionally add grants for example user for python scripts.

```
psql chinook < grants.sql > errors2.out
```

Next connect to chinook using VS Code Database Extension
In VS Code clone the following URL:  https://github.com/awksedgreep/pg_jsonb.git

You should see options to execute SQL statements next to the statements themselves.

```
'njoy,
Mark
```