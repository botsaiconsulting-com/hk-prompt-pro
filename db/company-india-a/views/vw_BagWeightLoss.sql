CREATE VIEW dbo.vw_BagWeightLoss
AS
SELECT BagNo,
       FromDept,
       ToDept,
       MovedAt,
       MetalWeightOutG - MetalWeightInG AS LossG
FROM dbo.BagMovement;
GO
