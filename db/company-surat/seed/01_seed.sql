SET NOCOUNT ON;

INSERT INTO dbo.Company (CompanyId, CompanyCode, CompanyName, IsActive) VALUES
    (1, 'SUR', N'Surat Unit (training)', 1),
    (9, 'TST', N'Training Test Company', 0);

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
    ('RG-1001', N'Solitaire ring', 'RING', '18K', 3.400, 3.200),
    ('ER-2001', N'Cluster studs', 'EARRING', '18K', 4.300, 4.100),
    ('PD-3001', N'Halo pendant', 'PENDANT', '18K', 2.800, 2.600),
    ('BR-4001', N'Tennis bracelet', 'BRACELET', '14K', 10.200, 9.800),
    ('BN-5001', N'Eternity bangle', 'BANGLE', '18K', 15.100, 14.500),
    ('BS-6001', N'Bridal set (ring and band)', 'SET', '18K', 7.900, 7.400);

INSERT INTO dbo.ClientStyle (ClientStyleCode, StyleCode, CustomerCode, ClientRef) VALUES
    ('AUR-RG-1001', 'RG-1001', 'AUR001', N'AUR-SOL-01'),
    ('NWF-BR-4001', 'BR-4001', 'NWF001', N'NW-TEN-7');

INSERT INTO dbo.BOM (StyleCode, ComponentCode, Qty, WeightG, Carats) VALUES
    ('RG-1001', 'G18Y', 1, 3.200, NULL),
    ('RG-1001', 'D-RND-010', 1, NULL, 0.100),
    ('ER-2001', 'G18Y', 1, 4.100, NULL),
    ('ER-2001', 'D-RND-005', 12, NULL, 0.600),
    ('ER-2001', 'FND-POST', 1, NULL, NULL),
    ('PD-3001', 'G18Y', 1, 2.600, NULL),
    ('PD-3001', 'D-RND-005', 16, NULL, 0.800),
    ('BR-4001', 'G14W', 1, 9.800, NULL),
    ('BR-4001', 'D-RND-005', 40, NULL, 2.000),
    ('BR-4001', 'FND-CLASP', 1, NULL, NULL),
    ('BN-5001', 'G18Y', 1, 14.500, NULL),
    ('BN-5001', 'D-RND-005', 30, NULL, 1.500),
    ('BS-6001', 'G18Y', 1, 7.400, NULL),
    ('BS-6001', 'D-PRN-020', 1, NULL, 0.200),
    ('BS-6001', 'D-RND-005', 10, NULL, 0.500);

INSERT INTO dbo.SalesOrder (OrderNo, CompanyId, CustomerCode, OrderDate, Status) VALUES
    ('S-260701', 1, 'AUR001', '2026-07-04', 'I'),
    ('S-260702', 1, 'NWF001', '2026-07-11', 'I'),
    ('S-260703', 1, 'LUM001', '2026-07-19', 'C'),
    ('S-260801', 1, 'AUR001', '2026-08-02', 'I'),
    ('S-260802', 1, 'CBJ001', '2026-08-14', 'I'),
    ('S-260803', 1, 'NWF001', '2026-08-27', 'O'),
    ('S-260901', 1, 'SIL001', '2026-09-03', 'I'),
    ('S-260902', 1, 'AUR001', '2026-09-16', 'O'),
    ('S-260903', 1, 'LUM001', '2026-09-24', 'I'),
    ('T-260701', 9, 'AUR001', '2026-07-08', 'C'),
    ('T-260901', 9, 'NWF001', '2026-09-09', 'C');

INSERT INTO dbo.SalesOrderLine (OrderNo, LineNumber, StyleCode, Qty, ProductionSalesPrice, ActualSellingPrice) VALUES
    ('S-260701', 1, 'RG-1001', 20, 48500.00, 48500.00),
    ('S-260701', 2, 'ER-2001', 10, 39800.00, 39800.00),
    ('S-260702', 1, 'BR-4001', 6, 112000.00, 104000.00),
    ('S-260703', 1, 'BN-5001', 4, 141000.00, 141000.00),
    ('S-260801', 1, 'PD-3001', 25, 27600.00, 27600.00),
    ('S-260801', 2, 'RG-1001', 10, 48500.00, 49900.00),
    ('S-260802', 1, 'BS-6001', 8, 86200.00, 86200.00),
    ('S-260803', 1, 'ER-2001', 12, 39800.00, 38200.00),
    ('S-260901', 1, 'BN-5001', 5, 141000.00, 141000.00),
    ('S-260902', 1, 'RG-1001', 15, 48500.00, 48500.00),
    ('S-260902', 2, 'BS-6001', 4, 86200.00, 82500.00),
    ('S-260903', 1, 'PD-3001', 30, 27600.00, 26800.00),
    ('T-260701', 1, 'RG-1001', 1, 1.00, 1.00),
    ('T-260901', 1, 'ER-2001', 1, 1.00, 1.00);

INSERT INTO dbo.BagMovement (BagNo, StyleCode, FromDept, ToDept, MovedAt, MetalWeightOutG, MetalWeightInG) VALUES
    ('BG-7001', 'RG-1001', 'CASTING', 'FILING', '2026-07-01 09:10', 68.400, 68.400),
    ('BG-7001', 'RG-1001', 'FILING', 'SETTING', '2026-07-01 15:40', 67.450, 67.450),
    ('BG-7001', 'RG-1001', 'SETTING', 'POLISHING', '2026-07-02 11:05', 67.200, 67.180),
    ('BG-7002', 'BR-4001', 'CASTING', 'FILING', '2026-07-03 10:20', 61.500, 61.500),
    ('BG-7002', 'BR-4001', 'FILING', 'SETTING', '2026-07-03 17:30', 60.650, 60.650),
    ('BG-7004', 'PD-3001', 'CASTING', 'FILING', '2026-08-05 09:00', 30.100, 30.100),
    ('BG-7004', 'PD-3001', 'FILING', 'SETTING', '2026-08-05 16:45', 29.700, 29.690),
    ('BG-7003', 'BN-5001', 'CASTING', 'FILING', '2026-09-01 09:45', 73.200, 73.200),
    ('BG-7003', 'BN-5001', 'FILING', 'SETTING', '2026-09-01 18:10', 72.380, 72.380),
    ('BG-7003', 'BN-5001', 'SETTING', 'POLISHING', '2026-09-02 12:30', 72.150, 72.150);
GO
