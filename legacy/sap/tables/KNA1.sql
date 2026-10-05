-- SAP customer master (cut down). SAP HANA.
CREATE COLUMN TABLE KNA1 (
    MANDT NVARCHAR(3)  NOT NULL,
    KUNNR NVARCHAR(10) NOT NULL,   -- customer number
    NAME1 NVARCHAR(35) NOT NULL,   -- name
    ORT01 NVARCHAR(35),            -- city
    LAND1 NVARCHAR(3),             -- country key
    PRIMARY KEY (MANDT, KUNNR)
);
