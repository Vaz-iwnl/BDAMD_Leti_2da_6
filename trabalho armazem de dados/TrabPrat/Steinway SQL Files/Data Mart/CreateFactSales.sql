IF NOT EXISTS (SELECT name FROM sys.tables WHERE name = 'FactSales')
CREATE TABLE [dbo].[FactSales](
	[SalesKey] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[SourceSalesID] [int] NOT NULL,
	[SourceLineID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[TotalAmount] [money] NOT NULL,
 CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED 
(
	[SalesKey] ASC
)
) ON [PRIMARY]

