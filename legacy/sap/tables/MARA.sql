-- SAP material master (cut down). SAP HANA.
CREATE COLUMN TABLE MARA (
    MANDT NVARCHAR(3)  NOT NULL,
    MATNR NVARCHAR(18) NOT NULL,   -- material number
    MTART NVARCHAR(4)  NOT NULL,   -- material type
    MATKL NVARCHAR(9),             -- material group
    PRIMARY KEY (MANDT, MATNR)
);
