declare @i int=0,@txtMessage nvarchar(500),@tbSize numeric(36,2)=0
,@maxTbSizeMb numeric(36,2)=200
 
while (1=1)
begin
                set @i=@i+1
-- check and delete old records
                select @tbSize= CAST(ROUND(((SUM(au.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) --AS [Table size (MB)]
                FROM sys.schemas s
                JOIN sys.tables t ON s.schema_id = t.schema_id
                JOIN sys.partitions p ON t.object_id = p.object_id
                JOIN sys.allocation_units au ON p.partition_id = au.container_id
                Where t.name = 'tbl_WhoIsActive'
                GROUP BY s.name, t.name, t.type_desc
--delete 10% old records if table size > than @maxTbSizeMb
                if @tbSize>@maxTbSizeMb
                begin
                               delete top (10) percent from tbl_WhoIsActive
                               set @txtMessage='!-----deleted --------- '+ cast(@@ROWCOUNT as nvarchar)  +'  ' + convert(varchar(5),getdate(),108)
                               raiserror (@txtMessage,0,1) with nowait
                               ALTER INDEX [PK_tbl_WhoIsActive] ON [dbo].[tbl_WhoIsActive] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
                end
-- fill
                EXEC sp_WhoIsActive  @format_output = 0, @destination_table = tbl_WhoIsActive
                -- print result
                set @txtMessage='step ' + cast(@i as nvarchar) +' | rows '+ cast(@@ROWCOUNT as nvarchar)+' | at '+convert(varchar(100),getdate(),120)+' | size '+ cast(@tbSize as nvarchar)
                raiserror (@txtMessage,0,1) with nowait
 -- delay
                waitfor delay'00:00:30'
-- break task at 00:59 for new task starting
                if (convert(varchar(5),getdate(),108)='00:59') break
 
end