SET NOCOUNT ON;

INSERT INTO dbo.Company (CompanyId, CompanyCode, CompanyName, IsActive) VALUES
    (3, 'INB', N'India Unit B (training)', 1);

INSERT INTO dbo.Customer (CustomerCode, CustomerName, City, Country) VALUES
    ('AUR001', N'Aurora Retail Group', N'Dubai', N'UAE'),
    ('NWF001', N'Northwind Fine Jewels', N'London', N'UK'),
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
    ('RG-1101', N'Platinum band', 'RING', 'PT950', 6.200, 6.000),
    ('ER-2101', N'Hoop earrings', 'EARRING', '14K', 5.600, 5.400),
    ('PD-3101', N'Initial pendant', 'PENDANT', '14K', 2.200, 2.050),
    ('BR-4101', N'Link bracelet', 'BRACELET', '18K', 12.300, 11.900),
    ('BS-6101', N'Engagement set', 'SET', 'PT950', 9.500, 9.100);

INSERT INTO dbo.ClientStyle (ClientStyleCode, StyleCode, CustomerCode, ClientRef) VALUES
    ('SIL-RG-1101', 'RG-1101', 'SIL001', N'SL-PB-06');

INSERT INTO dbo.BOM (StyleCode, ComponentCode, Qty, WeightG, Carats) VALUES
    ('RG-1101', 'PT950', 1, 6.000, NULL),
    ('ER-2101', 'G14W', 1, 5.400, NULL),
    ('ER-2101', 'FND-POST', 1, NULL, NULL),
    ('PD-3101', 'G14W', 1, 2.050, NULL),
    ('PD-3101', 'D-RND-005', 2, NULL, 0.100),
    ('BR-4101', 'G18Y', 1, 11.900, NULL),
    ('BR-4101', 'FND-CLASP', 1, NULL, NULL),
    ('BS-6101', 'PT950', 1, 9.100, NULL),
    ('BS-6101', 'D-PRN-020', 1, NULL, 0.200),
    ('BS-6101', 'D-RND-010', 4, NULL, 0.400);

INSERT INTO dbo.SalesOrder (OrderNo, CompanyId, CustCode, OrderDate, Status) VALUES
    ('B-260701', 3, 'NWF001', '2026-07-09', 'I'),
    ('B-260702', 3, 'AUR001', '2026-07-25', 'I'),
    ('B-260801', 3, 'SIL001', '2026-08-08', 'I'),
    ('B-260802', 3, 'CBJ001', '2026-08-20', 'C'),
    ('B-260901', 3, 'LUM001', '2026-09-11', 'O'),
    ('B-260902', 3, 'AUR001', '2026-09-26', 'I');

INSERT INTO dbo.SalesOrderLine (OrderNo, LineNumber, StyleCode, Qty, ProductionSalesPrice, ActualSellingPrice) VALUES
    ('B-260701', 1, 'RG-1101', 10, 29800.00, 29800.00),
    ('B-260702', 1, 'BR-4101', 5, 98700.00, 95000.00),
    ('B-260801', 1, 'ER-2101', 14, 31200.00, 31200.00),
    ('B-260801', 2, 'PD-3101', 20, 14900.00, 14900.00),
    ('B-260802', 1, 'BS-6101', 3, 121000.00, 121000.00),
    ('B-260901', 1, 'RG-1101', 8, 29800.00, 30500.00),
    ('B-260902', 1, 'BR-4101', 4, 98700.00, 98700.00),
    ('B-260902', 2, 'PD-3101', 15, 14900.00, 14200.00);

INSERT INTO dbo.BagMovement (BagNo, StyleCode, FromDept, ToDept, MovedAt, MetalWeightOutG, MetalWeightInG) VALUES
    ('BG-9201', 'RG-1101', 'CASTING', 'FILING', '2026-07-05 09:00', 61.000, 61.000),
    ('BG-9201', 'RG-1101', 'FILING', 'POLISHING', '2026-07-05 14:20', 60.550, 60.550),
    ('BG-9202', 'BR-4101', 'CASTING', 'FILING', '2026-07-20 10:40', 48.200, 48.200),
    ('BG-9202', 'BR-4101', 'FILING', 'SETTING', '2026-07-21 11:00', 47.600, 47.590);
GO
