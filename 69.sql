--69º
CREATE OR ALTER PROCEDURE REGION_TOTAL_EMPLOYEES
AS
BEGIN
    DECLARE @region_id BIGINT
    DECLARE @region_name NVARCHAR(25)
    DECLARE @max_region_id BIGINT
    DECLARE @list VARCHAR(MAX) = ''
    DECLARE @region_output VARCHAR(MAX) = ''
    
    -- Get the minimum and maximum region_id
    SELECT @region_id = MIN(region_id), @max_region_id = MAX(region_id)
    FROM regions
    
    -- Loop through each region
    WHILE @region_id <= @max_region_id
    BEGIN        
        -- Get the region name
        SELECT @region_name = region_name
        FROM regions
        WHERE region_id = @region_id
        
        -- Add region header to output
        SET @region_output = @region_name + CHAR(13) + CHAR(10) + 
                           '========================================' + CHAR(13) + CHAR(10)
        
        -- Check if the region has employees and get their country and counts
        IF EXISTS (
            SELECT 1 
            FROM employees e
            JOIN departments d ON e.department_id = d.department_id
            JOIN locations l ON d.location_id = l.location_id
            JOIN countries c ON l.country_id = c.country_id
            WHERE c.region_id = @region_id
        )
        BEGIN
            -- Build country and employee count string
            SELECT @region_output = @region_output + 
                   c.country_name + 
                   REPLICATE(' ', 40 - LEN(c.country_name) - LEN(CAST(COUNT(e.employee_id) AS VARCHAR))) + 
                   CAST(COUNT(e.employee_id) AS VARCHAR) + CHAR(13) + CHAR(10)
            FROM countries c
            JOIN locations l ON c.country_id = l.country_id
            JOIN departments d ON l.location_id = d.location_id
            JOIN employees e ON d.department_id = e.department_id
            WHERE c.region_id = @region_id
            GROUP BY c.country_name
            ORDER BY c.country_name
        END
        ELSE
        BEGIN
            -- If no employees in this region
            SET @region_output = @region_output + 'NO EMPLOYEES' + CHAR(13) + CHAR(10)
        END
        
        -- Add this region's output to the main output
        SET @list = @list + @region_output + CHAR(13) + CHAR(10)
        
        -- Move to next region
        SET @region_id = @region_id + 1
    END
    
    -- Print the final output
    PRINT @list
	-- Reset region output for this iteration
        SET @region_output = ''
END
GO
execute REGION_TOTAL_EMPLOYEES

GO

