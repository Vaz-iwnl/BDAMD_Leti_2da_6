IF NOT EXISTS (SELECT name FROM sys.tables WHERE name = 'DimProduct')
CREATE TABLE [dbo].[DimProduct](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](18) NOT NULL,
	[Description] [char](60) NOT NULL,
	[FamilyCode] [int] NOT NULL,
	[Stock] [numeric](13, 3) NOT NULL,
	[UnitPrice] [numeric](19, 6) NOT NULL,
	[OrderPoint] [numeric](10, 3) NOT NULL,
	[MinimunStock] [numeric](13, 3) NOT NULL,
	[StartSellingDate] [date] NOT NULL,
	[Category] [varchar](25) NOT NULL,
 CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
