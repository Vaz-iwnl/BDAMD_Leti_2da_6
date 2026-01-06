IF NOT EXISTS (SELECT name FROM sys.tables WHERE name = 'DimEmployees')
CREATE TABLE [dbo].[DimEmployees](
	[EmployeeKey] [int] IDENTITY(1,1) NOT NULL,
	[Number] [numeric](6, 0) NOT NULL,
	[Initials] [varchar](3) NOT NULL,
	[Code] [varchar](20) NOT NULL,
	[Forename] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Group] [varchar](20) NOT NULL,
	[Department] [int] NOT NULL,
	[Email] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DimEmployees] PRIMARY KEY CLUSTERED 
(
	[EmployeeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

