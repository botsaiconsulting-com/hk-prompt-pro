using HK.Supreme.Api.Models;

namespace HK.Supreme.Api.Services;

public interface IPricingService
{
    Quote Calculate(QuoteRequest request);
}
