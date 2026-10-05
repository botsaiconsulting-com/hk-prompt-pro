namespace HK.Supreme.Api.Models;

public sealed record MonthlySalesRow(string Company, string CustomerCode, string CustomerName, string SalesMonth, decimal NetValue);

public sealed record OrderLineRow(string OrderNo, DateOnly OrderDate, string Status, short LineNumber, string StyleCode, int Qty, decimal ActualSellingPrice);
