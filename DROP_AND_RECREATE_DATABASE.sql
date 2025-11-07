USE [master]
GO

-- Drop database if exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Bloomie')
BEGIN
    ALTER DATABASE [Bloomie] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [Bloomie]
END
GO

-- Create database
CREATE DATABASE [Bloomie]
GO

PRINT 'Database dropped and recreated successfully!'
