SET NOCOUNT ON;

INSERT INTO dbo.Company (CompanyId, CompanyCode, CompanyName, IsActive) VALUES
    (2, 'INA', N'India Unit A (training)', 1);

INSERT INTO dbo.Customer (CustomerCode, CustomerName, City, Country) VALUES
    ('AUR001', N'Aurora Retail Group', N'Dubai', N'UAE'),
    ('NWF001', N'Northwind Fine Jewellery Ltd', N'London', N'UK'),
    ('LUM001', N'Lumen & Co', N'Mumbai', N'India'),
    ('SIL001', N'Silverline Boutiques', N'Singapore', N'Singapore'),
    ('CBJ001', N'Coral Bay Jewellers', N'Sydney', N'Australia');

INSERT INTO dbo.RawMaterial (ComponentCode, ComponentType, Description, Uom, StdRate) VALUES
    ('G18Y', 'METAL', N'Gold 18K yellow', 'G', 6200.00),
    ('G14W', 'METAL', N'Gold 14K white', 'G', 4900.00),
    ('PT950', 'METAL', N'Platinum 950', 'G', 3300.00),
    ('D-RND-005', 'DIAMOND', N'Diamond round 0.05 ct', 'CT', 42000.00),
    ('D-RND-010', 'DIAMOND', N'Diamond round 0.10 ct', 'CT', 52000.00),
    ('D-PRN-020', 'DIAMOND', N'Diamond princess 0.20 ct', 'CT', 61000.00),
    ('CS-RUBY-025', 'COLOUR_STONE', N'Ruby 0.25 ct', 'CT', 18000.00),
    ('FND-CLASP', 'FINDING', N'Box clasp', 'PC', 350.00),
    ('FND-POST', 'FINDING', N'Earring post pair', 'PC', 220.00);

INSERT INTO dbo.StyleMaster (StyleCode, Description, Category, MetalPurity, GrossWeightG, NetMetalWeightG) VALUES
    ('RG-1001', N'Halo ring', 'RING', '14K', 3.100, 2.900),
    ('RG-1002', N'Three-stone ring', 'RING', '18K', 3.800, 3.550),
    ('ER-2002', N'Drop earrings', 'EARRING', '18K', 5.200, 4.900),
    ('PD-3002', N'Ruby pendant', 'PENDANT', '18K', 3.100, 2.850),
    ('BN-5002', N'Kada bangle', 'BANGLE', '18K', 18.400, 17.900);

INSERT INTO dbo.ClientStyle (ClientStyleCode, StyleCode, CustomerCode, ClientRef) VALUES
    ('LUM-RG-1001', 'RG-1001', 'LUM001', N'LUM-HALO-2');

INSERT INTO dbo.BOM (StyleCode, ComponentCode, Qty, WeightG, Carats) VALUES
    ('RG-1001', 'G14W', 1, 2.900, NULL),
    ('RG-1001', 'D-RND-010', 1, NULL, 0.100),
    ('RG-1002', 'G18Y', 1, 3.550, NULL),
    ('RG-1002', 'D-RND-010', 3, NULL, 0.300),
    ('ER-2002', 'G18Y', 1, 4.900, NULL),
    ('ER-2002', 'D-RND-005', 8, NULL, 0.400),
    ('ER-2002', 'FND-POST', 1, NULL, NULL),
    ('PD-3002', 'G18Y', 1, 2.850, NULL),
    ('PD-3002', 'CS-RUBY-025', 1, NULL, 0.250),
    ('PD-3002', 'D-RND-005', 6, NULL, 0.300),
    ('BN-5002', 'G18Y', 1, 17.900, NULL);

INSERT INTO dbo.SalesOrder (OrderNo, CompanyId, CustomerCode, OrderDate, Status) VALUES
    ('A-260701', 2, 'LUM001', '2026-07-06', 'I'),
    ('A-260702', 2, 'SIL001', '2026-07-22', 'I'),
    ('A-260801', 2, 'AUR001', '2026-08-05', 'I'),
    ('A-260802', 2, 'LUM001', '2026-08-18', 'C'),
    ('A-260803', 2, 'CBJ001', '2026-08-29', 'O'),
    ('A-260901', 2, 'AUR001', '2026-09-07', 'I'),
    ('A-260902', 2, 'NWF001', '2026-09-21', 'I');

INSERT INTO dbo.SalesOrderLine (OrderNo, LineNumber, StyleCode, Qty, ProductionSalesPrice, ActualSellingPrice) VALUES
    ('A-260701', 1, 'RG-1001', 18, 36900.00, 36900.00),
    ('A-260701', 2, 'RG-1002', 6, 61200.00, 61200.00),
    ('A-260702', 1, 'ER-2002', 10, 54400.00, 51900.00),
    ('A-260801', 1, 'BN-5002', 3, 168500.00, 168500.00),
    ('A-260802', 1, 'PD-3002', 12, 33400.00, 33400.00),
    ('A-260803', 1, 'RG-1002', 8, 61200.00, 63000.00),
    ('A-260901', 1, 'RG-1001', 12, 36900.00, 35500.00),
    ('A-260901', 2, 'ER-2002', 6, 54400.00, 54400.00),
    ('A-260902', 1, 'PD-3002', 20, 33400.00, 33400.00);

INSERT INTO dbo.BagMovement (BagNo, StyleCode, FromDept, ToDept, MovedAt, MetalWeightOutG, MetalWeightInG) VALUES
    ('BG-8101', 'RG-1002', 'CASTING', 'FILING', '2026-07-02 09:30', 22.100, 22.100),
    ('BG-8101', 'RG-1002', 'FILING', 'SETTING', '2026-07-02 16:10', 21.700, 21.700),
    ('BG-8102', 'BN-5002', 'CASTING', 'FILING', '2026-08-01 10:00', 54.300, 54.300),
    ('BG-8102', 'BN-5002', 'FILING', 'POLISHING', '2026-08-02 12:15', 53.650, 53.650);
GO
