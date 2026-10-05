using HK.Supreme.Api.Models;

namespace HK.Supreme.Api.Services;

/// <summary>
/// Quote for one piece. Rules are in docs/brd/pricing-spec.md:
/// metal value + making charge + stone value, GST at 3% on the subtotal,
/// rounded once, at the end, to the nearest rupee with halves rounded up.
/// </summary>
public sealed class PricingService : IPricingService
{
    public const decimal GstRate = 0.03m;

    public Quote Calculate(QuoteRequest request)
    {
        ArgumentNullException.ThrowIfNull(request);
        if (request.NetMetalWeightG <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(request), "Net metal weight must be greater than zero.");
        }

        var metalValue = request.NetMetalWeightG * request.MetalRatePerG;
        var makingCharge = request.NetMetalWeightG * request.MakingChargePerG;
        var stoneValue = request.Stones?.Sum(s => s.Carats * s.RatePerCarat) ?? 0m;

        var subtotal = metalValue + makingCharge + stoneValue;
        var gst = subtotal * GstRate;
        var total = Math.Round(subtotal + gst, 0, MidpointRounding.AwayFromZero);

        return new Quote(metalValue, makingCharge, stoneValue, subtotal, gst, total);
    }
}
