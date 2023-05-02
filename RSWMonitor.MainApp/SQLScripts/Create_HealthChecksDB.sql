USE [master]
GO
/****** Object:  Database [HealthChecksDB]    Script Date: 02.05.2023 11:29:45 ******/
CREATE DATABASE [HealthChecksDB]
 CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'HealthChecksDB', FILENAME = N'D:\Programs\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\HealthChecksDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'HealthChecksDB_log', FILENAME = N'D:\Programs\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\HealthChecksDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
-- WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HealthChecksDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HealthChecksDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HealthChecksDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HealthChecksDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HealthChecksDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HealthChecksDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HealthChecksDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HealthChecksDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HealthChecksDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HealthChecksDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HealthChecksDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [HealthChecksDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HealthChecksDB] SET RECOVERY FULL 
GO
ALTER DATABASE [HealthChecksDB] SET  MULTI_USER 
GO
ALTER DATABASE [HealthChecksDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HealthChecksDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HealthChecksDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HealthChecksDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HealthChecksDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HealthChecksDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HealthChecksDB', N'ON'
GO
ALTER DATABASE [HealthChecksDB] SET QUERY_STORE = OFF
GO
USE [HealthChecksDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Components]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Components](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComponentTypesId] [int] NOT NULL,
	[ConfigurationId] [int] NOT NULL,
	[ComponentName] [nvarchar](500) NOT NULL,
	[ComponentSignature] [nvarchar](500) NOT NULL,
	[ComponentRoletags] [nvarchar](500) NULL,
	[ComponentHasControls] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComponentTypes]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComponentTypes](
	[ComponentTypesId] [int] NOT NULL,
	[ComponentTypesName] [nvarchar](500) NULL,
 CONSTRAINT [PK_ComponentTypes] PRIMARY KEY CLUSTERED 
(
	[ComponentTypesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configurations]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configurations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uri] [nvarchar](500) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[DiscoveryService] [nvarchar](100) NULL,
 CONSTRAINT [PK_Configurations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Executions]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Executions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[OnStateFrom] [datetime2](7) NOT NULL,
	[LastExecuted] [datetime2](7) NOT NULL,
	[Uri] [nvarchar](500) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[DiscoveryService] [nvarchar](50) NULL,
 CONSTRAINT [PK_Executions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Failures]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Failures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HealthCheckName] [nvarchar](500) NOT NULL,
	[LastNotified] [datetime2](7) NOT NULL,
	[IsUpAndRunning] [bit] NOT NULL,
 CONSTRAINT [PK_Failures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthCheckExecutionEntries]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthCheckExecutionEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Status] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Duration] [time](7) NOT NULL,
	[HealthCheckExecutionId] [int] NULL,
	[Tags] [nvarchar](max) NULL,
 CONSTRAINT [PK_HealthCheckExecutionEntries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthCheckExecutionHistories]    Script Date: 02.05.2023 11:29:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthCheckExecutionHistories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[On] [datetime2](7) NOT NULL,
	[HealthCheckExecutionId] [int] NULL,
 CONSTRAINT [PK_HealthCheckExecutionHistories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Components] ON 

INSERT [dbo].[Components] ([Id], [ComponentTypesId], [ConfigurationId], [ComponentName], [ComponentSignature], [ComponentRoletags], [ComponentHasControls]) VALUES (1, 1, 9, N'a', N'a', N'a', 0)
SET IDENTITY_INSERT [dbo].[Components] OFF
GO
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (1, N'Database')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (2, N'Service')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (3, N'App')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (4, N'URL')
GO
SET IDENTITY_INSERT [dbo].[Configurations] ON 

INSERT [dbo].[Configurations] ([Id], [Uri], [Name], [DiscoveryService]) VALUES (9, N'q', N'q', NULL)
INSERT [dbo].[Configurations] ([Id], [Uri], [Name], [DiscoveryService]) VALUES (12, N'r', N'r', NULL)
SET IDENTITY_INSERT [dbo].[Configurations] OFF
GO
/****** Object:  Index [IX_HealthCheckExecutionEntries_HealthCheckExecutionId]    Script Date: 02.05.2023 11:29:45 ******/
CREATE NONCLUSTERED INDEX [IX_HealthCheckExecutionEntries_HealthCheckExecutionId] ON [dbo].[HealthCheckExecutionEntries]
(
	[HealthCheckExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HealthCheckExecutionHistories_HealthCheckExecutionId]    Script Date: 02.05.2023 11:29:45 ******/
CREATE NONCLUSTERED INDEX [IX_HealthCheckExecutionHistories_HealthCheckExecutionId] ON [dbo].[HealthCheckExecutionHistories]
(
	[HealthCheckExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Components] ADD  DEFAULT ((1)) FOR [ComponentTypesId]
GO
ALTER TABLE [dbo].[Components] ADD  DEFAULT ((0)) FOR [ComponentHasControls]
GO
ALTER TABLE [dbo].[Components]  WITH CHECK ADD  CONSTRAINT [FK_Components_ComponentTypes] FOREIGN KEY([ComponentTypesId])
REFERENCES [dbo].[ComponentTypes] ([ComponentTypesId])
GO
ALTER TABLE [dbo].[Components] CHECK CONSTRAINT [FK_Components_ComponentTypes]
GO
ALTER TABLE [dbo].[Components]  WITH CHECK ADD  CONSTRAINT [FK_Components_Configurations] FOREIGN KEY([ConfigurationId])
REFERENCES [dbo].[Configurations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Components] CHECK CONSTRAINT [FK_Components_Configurations]
GO
ALTER TABLE [dbo].[HealthCheckExecutionEntries]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckExecutionEntries_Executions_HealthCheckExecutionId] FOREIGN KEY([HealthCheckExecutionId])
REFERENCES [dbo].[Executions] ([Id])
GO
ALTER TABLE [dbo].[HealthCheckExecutionEntries] CHECK CONSTRAINT [FK_HealthCheckExecutionEntries_Executions_HealthCheckExecutionId]
GO
ALTER TABLE [dbo].[HealthCheckExecutionHistories]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckExecutionHistories_Executions_HealthCheckExecutionId] FOREIGN KEY([HealthCheckExecutionId])
REFERENCES [dbo].[Executions] ([Id])
GO
ALTER TABLE [dbo].[HealthCheckExecutionHistories] CHECK CONSTRAINT [FK_HealthCheckExecutionHistories_Executions_HealthCheckExecutionId]
GO
USE [master]
GO
ALTER DATABASE [HealthChecksDB] SET  READ_WRITE 
GO
