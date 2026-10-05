using HK.Supreme.Api.Data;
using HK.Supreme.Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace HK.Supreme.Api.Controllers;

[ApiController]
[Route("api/orders")]
public sealed class OrdersController : ControllerBase
{
    private readonly IOrderRepository _orders;
    private readonly ILogger<OrdersController> _logger;

    public OrdersController(IOrderRepository orders, ILogger<OrdersController> logger)
    {
        _orders = orders;
        _logger = logger;
    }

    // GET api/orders/surat/monthly-sales?from=2026-07-01&to=2026-10-01
    [HttpGet("{company}/monthly-sales")]
    public async Task<ActionResult<IReadOnlyList<MonthlySalesRow>>> GetMonthlySales(
        string company, [FromQuery] DateOnly from, [FromQuery] DateOnly to, CancellationToken cancellationToken)
    {
        if (!Companies.IsKnown(company))
        {
            return NotFound($"Unknown company '{company}'.");
        }

        if (to <= from)
        {
            return BadRequest("'to' must be after 'from'.");
        }

        _logger.LogInformation("Monthly sales for {Company} from {From} to {To}", company, from, to);
        return Ok(await _orders.GetMonthlySalesAsync(company, from, to, cancellationToken));
    }

    // GET api/orders/surat/customers/AUR001?from=2026-07-01&to=2026-10-01
    [HttpGet("{company}/customers/{customerCode}")]
    public async Task<ActionResult<IReadOnlyList<OrderLineRow>>> GetCustomerOrders(
        string company, string customerCode, [FromQuery] DateOnly from, [FromQuery] DateOnly to, CancellationToken cancellationToken)
    {
        if (!Companies.IsKnown(company))
        {
            return NotFound($"Unknown company '{company}'.");
        }

        return Ok(await _orders.GetCustomerOrdersAsync(company, customerCode, from, to, cancellationToken));
    }
}
