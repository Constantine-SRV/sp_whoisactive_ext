# sp_whoisactive_ext
Job stores sp_whoisactive result to table and view wit int wait time

fullScriptCreateDbAdmintollsWithAllAndJob.sql creates all objects.
Default database adminTools, replace the name to you DB.
Change file location in 9 and 11 lines.

To adjust log size history and snapshot time edit: 
,@maxTbSizeMb numeric(36,2)=200 (line 2); 
and 
waitfor delay'00:00:30' (line 29);
In loopToFill_tbl_WhoIsActive_and_DellOldRecords.sql or step 1 job sp_whoisactive_loop
