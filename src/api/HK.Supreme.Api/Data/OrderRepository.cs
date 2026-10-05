using System.Data;
using System.Data.Common;
using HK.Supreme.Api.Models;

namespace HK.Supreme.Api.Data;

public sealed class OrderRepository : IOrderRepository
{
    // Net sales value is quantity x actual selling price. Cancelled orders are excluded.
    private const string MonthlySalesSql = @"
SELECT o.CustomerCode,
       c.CustomerName,
       CONVERT(char(7), o.OrderDate, 126) AS SalesMonth,
       SUM(l.Qty * l.ActualSellingPrice)  AS NetValue
FROM dbo.SalesOrder o
JOIN dbo.SalesOrderLine l ON l.OrderNo = o.OrderNo
JOIN dbo.Customer c       ON c.CustomerCode = o.CustomerCode
WHERE o.Status <> 'C'
  AND o.OrderDate >= @From
  AND o.OrderDate <  @To
GROUP BY o.CustomerCode, c.CustomerName, CONVERT(char(7), o.OrderDate, 126)
ORDER BY SalesMonth, NetValue DESC;";

    private readonly ICompanyConnectionFactory _connections;

    public OrderRepository(ICompanyConnectionFactory connections)
    {
        _connections = connections;
    }

    public async Task<IReadOnlyList<MonthlySalesRow>> GetMonthlySalesAsync(string company, DateOnly from, DateOnly to, CancellationToken cancellationToken)
    {
        await using var connection = await _connections.OpenAsync(company, cancellationToken);
        await using var command = connection.CreateCommand();
        command.CommandText = MonthlySalesSql;
        AddParameter(command, "@From", DbType.Date, from.ToDateTime(TimeOnly.MinValue));
        AddParameter(command, "@To", DbType.Date, to.ToDateTime(TimeOnly.MinValue));

        var rows = new List<MonthlySalesRow>();
        await using var reader = await command.ExecuteReaderAsync(cancellationToken);
        while (await reader.ReadAsync(cancellationToken))
        {
            rows.Add(new MonthlySalesRow(
                company,
                reader.GetString(0),
                reader.GetString(1),
                reader.GetString(2),
                reader.GetDecimal(3)));
        }

        return rows;
    }

    public async Task<IReadOnlyList<OrderLineRow>> GetCustomerOrdersAsync(string company, string customerCode, DateOnly from, DateOnly to, CancellationToken cancellationToken)
    {
        await using var connection = await _connections.OpenAsync(company, cancellationToken);
        await using var command = connection.CreateCommand();
        // faster than the procedure
        command.CommandText = $@"
SELECT o.OrderNo, o.OrderDate, o.Status, l.LineNumber, l.StyleCode, l.Qty, l.ActualSellingPrice
FROM dbo.SalesOrder o
JOIN dbo.SalesOrderLine l ON l.OrderNo = o.OrderNo
WHERE o.CustomerCode = '{customerCode}'
  AND o.OrderDate >= '{from:yyyy-MM-dd}' AND o.OrderDate < '{to:yyyy-MM-dd}'
ORDER BY o.OrderDate, o.OrderNo, l.LineNumber";

        var rows = new List<OrderLineRow>();
        await using var reader = await command.ExecuteReaderAsync(cancellationToken);
        while (await reader.ReadAsync(cancellationToken))
        {
            rows.Add(new OrderLineRow(
                reader.GetString(0),
                DateOnly.FromDateTime(reader.GetDateTime(1)),
                reader.GetString(2),
                reader.GetInt16(3),
                reader.GetString(4),
                reader.GetInt32(5),
                reader.GetDecimal(6)));
        }

        return rows;
    }

    private static void AddParameter(DbCommand command, string name, DbType type, object value)
    {
        var parameter = command.CreateParameter();
        parameter.ParameterName = name;
        parameter.DbType = type;
        parameter.Value = value;
        command.Parameters.Add(parameter);
    }
}
