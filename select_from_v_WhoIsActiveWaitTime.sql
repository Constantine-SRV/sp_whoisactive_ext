SELECT TOP (1000) [collection_time]
      ,[session_id]
      ,[blocking_session_id]
      ,[waitMs]
      ,[waitType]
      ,[sql_text]
      ,[login_name]
      ,[CPU]
      ,[tempdb_allocations]
      ,[tempdb_current]
      ,[reads]
      ,[writes]
      ,[physical_reads]
      ,[used_memory]
      ,[status]
      ,[open_tran_count]
      ,[percent_complete]
      ,[host_name]
      ,[database_name]
      ,[program_name]
	  ,dbo.fn_JobNameFromProgramName([program_name]) AS job_name
      ,[start_time]
      ,[login_time]
      ,[request_id]
      ,[wait_info]
      ,[recordID]
  FROM [admintools].[dbo].[v_WhoIsActiveWaitTime]
  where 1=1
  --and collection_time='2026-03-28T20:34:11.320'
   and waitMs>0
    and waitType not in ('waitfor','ASYNC_NETWORK_IO','BACKUPTHREAD','BACKUPIO','ASYNC_IO_COMPLETION')
  order by collection_time desc ,session_id desc
