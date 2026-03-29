USE [admintools]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_JobNameFromProgramName]    Script Date: 30.03.2026 3:43:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[fn_JobNameFromProgramName]
(
    @program_name NVARCHAR(256)
)
RETURNS NVARCHAR(256)
AS
BEGIN
    DECLARE @job_id   uniqueidentifier;
    DECLARE @job_name NVARCHAR(256);
    DECLARE @hex      NVARCHAR(34);
    DECLARE @pos      INT;

    -- Проверяем что строка вообще содержит паттерн агента
    SET @pos = CHARINDEX('0x', @program_name);

    IF @pos = 0 OR @program_name NOT LIKE 'SQLAgent - TSQL JobStep%'
        RETURN NULL;

    SET @hex = '0x' + SUBSTRING(@program_name, @pos + 2, 32);

    -- Доп. защита: убеждаемся что извлекли ровно 32 hex символа
    IF LEN(@hex) <> 34
        RETURN NULL;

    SET @job_id = CONVERT(uniqueidentifier,
                      CONVERT(binary(16),
                          CONVERT(varbinary, @hex, 1)
                      )
                  );

    SELECT @job_name = name
    FROM msdb.dbo.sysjobs
    WHERE job_id = @job_id;

    RETURN @job_name;
END;
GO
