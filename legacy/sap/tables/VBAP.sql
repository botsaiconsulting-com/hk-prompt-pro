-- SAP sales document item (cut down). SAP HANA.
CREATE COLUMN TABLE VBAP (
    MANDT  NVARCHAR(3)   NOT NULL,
    VBELN  NVARCHAR(10)  NOT NULL,   -- sales document number
    POSNR  NVARCHAR(6)   NOT NULL,   -- item number
    MATNR  NVARCHAR(18)  NOT NULL,   -- material (style)
    KWMENG DECIMAL(15,3) NOT NULL,   -- order quantity
    NETWR  DECIMAL(15,2) NOT NULL,   -- net value of the item
    ABGRU  NVARCHAR(2)   NOT NULL,   -- reason for rejection; blank when the item is not rejected
    PRIMARY KEY (MANDT, VBELN, POSNR)
);
