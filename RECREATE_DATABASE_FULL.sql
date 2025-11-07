-- =============================================
-- Script: TẠO LẠI DATABASE VÀ IMPORT DỮ LIỆU
-- Hướng dẫn sử dụng:
-- 1. Chạy script này để xóa và tạo lại database
-- 2. Chạy: dotnet ef database update
-- 3. Import dữ liệu từ file "Bloomie (1).sql"
-- =============================================

USE master;
GO

-- Đóng tất cả connections đến database Bloomie
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Bloomie')
BEGIN
    PRINT 'Đang đóng tất cả connections...'
    ALTER DATABASE [Bloomie] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    PRINT 'Đang xóa database...'
    DROP DATABASE [Bloomie];

    PRINT '✓ Database Bloomie đã được xóa!'
END
GO

-- Tạo lại database Bloomie
CREATE DATABASE [Bloomie]
GO

USE [Bloomie]
GO

PRINT ''
PRINT '========================================='
PRINT '✓ Database Bloomie đã được tạo lại!'
PRINT '========================================='
PRINT ''
PRINT 'BƯỚC TIẾP THEO:'
PRINT '1. Chạy lệnh: dotnet ef database update'
PRINT '   (Lệnh này sẽ tạo TẤT CẢ các bảng bao gồm ChatConversations và ChatMessages)'
PRINT ''
PRINT '2. Import dữ liệu từ file: Bloomie (1).sql'
PRINT '   - Mở file trong SQL Server Management Studio'
PRINT '   - Chọn database Bloomie'
PRINT '   - Chạy script'
PRINT ''
PRINT 'LƯU Ý: Chức năng chatbox SẼ ĐƯỢC TẠO LẠI tự động!'
PRINT '========================================='
GO
