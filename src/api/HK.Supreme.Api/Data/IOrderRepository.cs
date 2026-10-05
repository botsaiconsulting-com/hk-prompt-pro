using HK.Supreme.Api.Models;

namespace HK.Supreme.Api.Data;

public interface IOrderRepository
{
    Task<IReadOnlyList<MonthlySalesRow>> GetMonthlySalesAsync(string company, DateOnly from, DateOnly to, CancellationToken cancellationToken);

    Task<IReadOnlyList<OrderLineRow>> GetCustomerOrdersAsync(string company, string customerCode, DateOnly from, DateOnly to, CancellationToken cancellationToken);
}
