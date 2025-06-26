SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_WhoIsActive](
	[session_id] [smallint] NOT NULL,
	[sql_text] [varchar](max) NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[wait_info] [nvarchar](4000) NULL,
	[tran_log_writes] [nvarchar](4000) NULL,
	[CPU] [int] NULL,
	[tempdb_allocations] [bigint] NULL,
	[tempdb_current] [bigint] NULL,
	[blocking_session_id] [smallint] NULL,
	[reads] [bigint] NULL,
	[writes] [bigint] NULL,
	[physical_reads] [bigint] NULL,
	[used_memory] [bigint] NOT NULL,
	[status] [varchar](30) NOT NULL,
	[tran_start_time] [datetime] NULL,
	[open_tran_count] [smallint] NULL,
	[percent_complete] [real] NULL,
	[host_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[start_time] [datetime] NOT NULL,
	[login_time] [datetime] NULL,
	[request_id] [int] NULL,
	[collection_time] [datetime] NOT NULL,
	[recordID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tbl_WhoIsActive] PRIMARY KEY CLUSTERED 
(
	[recordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
--, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
