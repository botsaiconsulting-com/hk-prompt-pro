using HK.Supreme.Api.Models;
using HK.Supreme.Api.Services;
using Microsoft.AspNetCore.Mvc;

namespace HK.Supreme.Api.Controllers;

[ApiController]
[Route("api/pricing")]
public sealed class PricingController : ControllerBase
{
    private readonly IPricingService _pricing;

    public PricingController(IPricingService pricing)
    {
        _pricing = pricing;
    }

    // POST api/pricing/quote
    [HttpPost("quote")]
    public ActionResult<Quote> Quote([FromBody] QuoteRequest request)
    {
        if (request.NetMetalWeightG <= 0)
        {
            return BadRequest("Net metal weight must be greater than zero.");
        }

        return Ok(_pricing.Calculate(request));
    }
}
