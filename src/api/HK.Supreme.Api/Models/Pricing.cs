namespace HK.Supreme.Api.Models;

public sealed record StoneLine(decimal Carats, decimal RatePerCarat);

public sealed record QuoteRequest(decimal NetMetalWeightG, decimal MetalRatePerG, decimal MakingChargePerG, IReadOnlyList<StoneLine>? Stones);

public sealed record Quote(decimal MetalValue, decimal MakingCharge, decimal StoneValue, decimal Subtotal, decimal Gst, decimal Total);
