-- Create a stored procedure to get the data type of a column in a table
CREATE PROCEDURE sp_GetColumnDataType
    @TableName NVARCHAR(255),
    @ColumnName NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COLUMN_NAME, DATA_TYPE
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TableName
      AND COLUMN_NAME = @ColumnName;
END
GO

-- Create a stored procedure to get the count of NULL values in a column
CREATE PROCEDURE sp_GetNullCount
    @TableName NVARCHAR(255),
    @ColumnName NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = N'SELECT COUNT(*) AS NullCount FROM ' + QUOTENAME(@TableName) +
               N' WHERE ' + QUOTENAME(@ColumnName) + N' IS NULL;';
    EXEC sp_executesql @SQL;
END
GO

-- Create a stored procedure to convert a varchar column to a date column,
-- with optional calls to display the column's data type and NULL count.
CREATE PROCEDURE sp_ConvertVarcharToDateValidated
    @TableName NVARCHAR(255),
    @ColumnName NVARCHAR(255),
    @ConversionStyle INT = 105,
    @IncludeDataType BIT = 1,
    @IncludeNullCount BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    -- Print description of arguments and their default values
    PRINT 'sp_ConvertVarcharToDateValidated Arguments:';
    PRINT '  @TableName (NVARCHAR(255)): Name of the target table.';
    PRINT '  @ColumnName (NVARCHAR(255)): Name of the column to be converted.';
    PRINT '  @ConversionStyle (INT, default 105): The conversion style for TRY_CONVERT.';
    PRINT '  @DataType (BIT, default 1): If 1, calls sp_GetColumnDataType to display column data type.';
    PRINT '  @NullCount (BIT, default 1): If 1, calls sp_GetNullCount to display count of NULLs.';

    DECLARE @TempColumn NVARCHAR(255) = @ColumnName + '_temp';
    DECLARE @SQL NVARCHAR(MAX);

    -- 1. Add a temporary column to hold the date values
    SET @SQL = N'ALTER TABLE ' + QUOTENAME(@TableName) + 
               N' ADD ' + QUOTENAME(@TempColumn) + N' date;';
    EXEC sp_executesql @SQL;
    PRINT 'Temporary column ' + @TempColumn + ' added.';

    -- 2. Update the temporary column using the provided conversion style
    SET @SQL = N'UPDATE ' + QUOTENAME(@TableName) +
               N' SET ' + QUOTENAME(@TempColumn) + 
               N' = TRY_CONVERT(date, ' + QUOTENAME(@ColumnName) + 
               N', ' + CAST(@ConversionStyle AS NVARCHAR(10)) + N');';
    EXEC sp_executesql @SQL;
    PRINT 'Data conversion completed using conversion style ' + CAST(@ConversionStyle AS NVARCHAR(10)) + '.';

    -- 3. Drop the old varchar column
    SET @SQL = N'ALTER TABLE ' + QUOTENAME(@TableName) +
               N' DROP COLUMN ' + QUOTENAME(@ColumnName) + N';';
    EXEC sp_executesql @SQL;
    PRINT 'Old column ' + @ColumnName + ' dropped.';

    -- 4. Rename the temporary column to the original column name
    SET @SQL = N'EXEC sp_rename ''' + @TableName + N'.' + @TempColumn +
               N''', ''' + @ColumnName + N''', ''COLUMN'';';
    EXEC sp_executesql @SQL;
    PRINT 'Temporary column ' + @TempColumn + ' renamed to ' + @ColumnName + '.';

    -- Optionally, call the stored procedure to get the column data type
    IF @IncludeDataType = 1
    BEGIN
        PRINT 'Retrieving data type for column ' + @ColumnName + '.';
        EXEC sp_GetColumnDataType @TableName, @ColumnName;
        PRINT 'Column data type retrieved.';
    END

    -- Optionally, call the stored procedure to get the count of NULL values
    IF @IncludeNullCount = 1
    BEGIN
        PRINT 'Retrieving NULL count for column ' + @ColumnName + '.';
        EXEC sp_GetNullCount @TableName, @ColumnName;
        PRINT 'NULL count retrieved.';
    END

    PRINT 'converted to Date completed successfully.';
END
GO


-- Create a stored procedure to convert multiple varchar columns to date columns,
-- with optional calls to display the column's data type and NULL count.
CREATE PROCEDURE sp_ConvertMultipleVarcharToDateValidated
    @TableName NVARCHAR(255),
    @Columns NVARCHAR(MAX), -- comma-separated list of column names, e.g.: 'issue_date,last_credit_pull_date'
    @ConversionStyle INT = 105,
    @IncludeDataType BIT = 1,
    @IncludeNullCount BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        PRINT 'sp_ConvertMultipleVarcharToDateValidated Arguments:';
        PRINT '  @TableName: ' + @TableName;
        PRINT '  @Columns: ' + @Columns;
        PRINT '  @ConversionStyle (INT, default 105): ' + CAST(@ConversionStyle AS NVARCHAR(10));
        PRINT '  @IncludeDataType (BIT, default 1): ' + CAST(@IncludeDataType AS NVARCHAR(10));
        PRINT '  @IncludeNullCount (BIT, default 1): ' + CAST(@IncludeNullCount AS NVARCHAR(10));

        -- Split the comma-separated column names into a table variable
        DECLARE @cols TABLE (col NVARCHAR(255));
        INSERT INTO @cols (col)
        SELECT LTRIM(RTRIM(value))
        FROM STRING_SPLIT(@Columns, ',');

        DECLARE @CurrentColumn NVARCHAR(255);
        DECLARE @TempColumn NVARCHAR(255);
        DECLARE @SQL NVARCHAR(MAX);

        DECLARE ColumnCursor CURSOR FOR
            SELECT col FROM @cols;

        OPEN ColumnCursor;
        FETCH NEXT FROM ColumnCursor INTO @CurrentColumn;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @TempColumn = @CurrentColumn + '_temp';
            PRINT 'Converting column: ' + @CurrentColumn;

            -- 1. Add a temporary column to hold the date values
            SET @SQL = N'ALTER TABLE ' + QUOTENAME(@TableName) + 
                       N' ADD ' + QUOTENAME(@TempColumn) + N' date;';
            EXEC sp_executesql @SQL;
            PRINT 'Temporary column ' + @TempColumn + ' added for ' + @CurrentColumn + '.';

            -- 2. Update the temporary column using the provided conversion style
            SET @SQL = N'UPDATE ' + QUOTENAME(@TableName) +
                       N' SET ' + QUOTENAME(@TempColumn) + 
                       N' = TRY_CONVERT(date, ' + QUOTENAME(@CurrentColumn) + 
                       N', ' + CAST(@ConversionStyle AS NVARCHAR(10)) + N');';
            EXEC sp_executesql @SQL;
            PRINT 'Data conversion completed for ' + @CurrentColumn + ' using conversion style ' + CAST(@ConversionStyle AS NVARCHAR(10)) + '.';

            -- 3. Drop the old varchar column
            SET @SQL = N'ALTER TABLE ' + QUOTENAME(@TableName) +
                       N' DROP COLUMN ' + QUOTENAME(@CurrentColumn) + N';';
            EXEC sp_executesql @SQL;
            PRINT 'Old column ' + @CurrentColumn + ' dropped.';

            -- 4. Rename the temporary column to the original column name
            SET @SQL = N'EXEC sp_rename ''' + @TableName + N'.' + @TempColumn +
                       N''', ''' + @CurrentColumn + N''', ''COLUMN'';';
            EXEC sp_executesql @SQL;
            PRINT 'Temporary column ' + @TempColumn + ' renamed to ' + @CurrentColumn + '.';

            -- Optionally, call sp_GetColumnDataType
            IF @IncludeDataType = 1
            BEGIN
                PRINT 'Retrieving data type for ' + @CurrentColumn + '.';
                EXEC sp_GetColumnDataType @TableName, @CurrentColumn;
                PRINT 'Column data type retrieved.';
            END

            -- Optionally, call sp_GetNullCount
            IF @IncludeNullCount = 1
            BEGIN
                PRINT 'Retrieving NULL count for ' + @CurrentColumn + '.';
                EXEC sp_GetNullCount @TableName, @CurrentColumn;
                PRINT 'NULL count retrieved.';
            END

            FETCH NEXT FROM ColumnCursor INTO @CurrentColumn;
        END

        CLOSE ColumnCursor;
        DEALLOCATE ColumnCursor;

        COMMIT TRANSACTION;
        PRINT 'sp_ConvertMultipleVarcharToDateValidated procedure completed successfully for all specified columns.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        PRINT 'Error encountered: ' + @ErrMsg;
        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END
GO