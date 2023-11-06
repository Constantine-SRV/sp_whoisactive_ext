CREATE VIEW [dbo].[v_WhoIsActiveWaitTime]
AS
SELECT collection_time, session_id, blocking_session_id, SUBSTRING(ISNULL(wait_info, '(0ms)'),
CHARINDEX('(', ISNULL(wait_info, '(0ms)')) + 1, CHARINDEX('ms)', ISNULL(wait_info, '(0ms)')) - CHARINDEX('(', ISNULL(wait_info, '(0)')) - 1) AS waitMs,
SUBSTRING(ISNULL(wait_info, '(0ms)'), CHARINDEX(')', ISNULL(wait_info, '(0ms)')) + 1, LEN(ISNULL(wait_info, '(0ms)'))) AS waitType,
sql_text, login_name, CPU, tempdb_allocations,
tempdb_current, reads, writes, physical_reads,
used_memory, status, open_tran_count, percent_complete, host_name, database_name, program_name,
start_time, login_time, request_id, wait_info, recordID
FROM  dbo.tbl_WhoIsActive
GO