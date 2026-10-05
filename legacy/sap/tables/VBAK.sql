-- SAP sales document header (cut down). SAP HANA.
CREATE COLUMN TABLE VBAK (
    MANDT    NVARCHAR(3)   NOT NULL,   -- client
    VBELN    NVARCHAR(10)  NOT NULL,   -- sales document number
    ERDAT    NVARCHAR(8)   NOT NULL,   -- created on, YYYYMMDD
    AUART    NVARCHAR(4)   NOT NULL,   -- sales document type
    KUNNR    NVARCHAR(10)  NOT NULL,   -- sold-to customer
    BUKRS_VF NVARCHAR(4)   NOT NULL,   -- company code to be billed
    WAERK    NVARCHAR(5)   NOT NULL,   -- document currency
    NETWR    DECIMAL(15,2) NOT NULL,   -- net value of the document
    PRIMARY KEY (MANDT, VBELN)
);
