-- Creates the read-only training login used by every exercise.
-- Run as an administrator on the TRAINING instance only, with:  -v RO_PASSWORD="<password>"
-- The login can read all three company databases and run one read procedure. It cannot write,
-- delete, change schema or run the procedures that write.
USE master;
GO
IF SUSER_ID('hk_training_ro') IS NULL
    CREATE LOGIN hk_training_ro WITH PASSWORD = '$(RO_PASSWORD)', CHECK_POLICY = ON, DEFAULT_DATABASE = HK_SURAT;
ELSE
    ALTER LOGIN hk_training_ro WITH PASSWORD = '$(RO_PASSWORD)';
GO
USE HK_SURAT;
GO
IF USER_ID('hk_training_ro') IS NULL CREATE USER hk_training_ro FOR LOGIN hk_training_ro;
ALTER ROLE db_datareader ADD MEMBER hk_training_ro;
GRANT EXECUTE ON dbo.usp_GetCustomerOrders TO hk_training_ro;
GO
USE HK_INDIA_A;
GO
IF USER_ID('hk_training_ro') IS NULL CREATE USER hk_training_ro FOR LOGIN hk_training_ro;
ALTER ROLE db_datareader ADD MEMBER hk_training_ro;
GRANT EXECUTE ON dbo.usp_GetCustomerOrders TO hk_training_ro;
GO
USE HK_INDIA_B;
GO
IF USER_ID('hk_training_ro') IS NULL CREATE USER hk_training_ro FOR LOGIN hk_training_ro;
ALTER ROLE db_datareader ADD MEMBER hk_training_ro;
GRANT EXECUTE ON dbo.usp_GetCustomerOrders TO hk_training_ro;
GO
