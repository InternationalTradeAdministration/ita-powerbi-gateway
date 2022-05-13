CREATE OR
ALTER PROCEDURE imau.insert_or_update_ihs_dataset @name nvarchar(100),
                                                  @direction nvarchar(15),
                                                  @additional_parameters nvarchar(4000),
                                                  @updated_at datetimeoffset(0)
AS
BEGIN
    DECLARE @id AS bigint;

    IF @direction NOT IN ('import', 'export', 'importandexport', 'exportandimport')
        THROW 50000, 'Invalid direction', 1

    SELECT @id = id
    FROM imau.IHS_DATASETS
    WHERE name = @name

    IF @id IS NULL
        BEGIN
            INSERT INTO imau.IHS_DATASETS(name, direction, additional_parameters, created_at, updated_at)
            VALUES (LOWER(@name), LOWER(@direction), @additional_parameters, @updated_at, @updated_at);
            SELECT @@IDENTITY AS id;
        END
    ELSE
        BEGIN
            UPDATE imau.IHS_DATASETS
            SET direction             = @direction,
                additional_parameters = @additional_parameters,
                updated_at            = @updated_at
            WHERE id = @id;
            SELECT @id as id;
        END
END
