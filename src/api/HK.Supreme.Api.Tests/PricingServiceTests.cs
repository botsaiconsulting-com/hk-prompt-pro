using HK.Supreme.Api.Models;
using HK.Supreme.Api.Services;

namespace HK.Supreme.Api.Tests;

public class PricingServiceTests
{
    private readonly PricingService _pricing = new();

    [Fact]
    public void Calculate_MetalAndMakingOnly_AddsGstAndRounds()
    {
        // 3.2 g x 6,200 = 19,840; making 3.2 g x 950 = 3,040; subtotal 22,880; GST 686.40; total 23,566.40 -> 23,566
        var quote = _pricing.Calculate(new QuoteRequest(3.2m, 6200m, 950m, null));

        Assert.Equal(19840m, quote.MetalValue);
        Assert.Equal(3040m, quote.MakingCharge);
        Assert.Equal(22880m, quote.Subtotal);
        Assert.Equal(686.40m, quote.Gst);
        Assert.Equal(23566m, quote.Total);
    }

    [Fact]
    public void Calculate_WithStones_AddsStoneValue()
    {
        var stones = new List<StoneLine> { new(0.10m, 52000m), new(0.60m, 42000m) };

        var quote = _pricing.Calculate(new QuoteRequest(3.2m, 6200m, 950m, stones));

        Assert.Equal(30400m, quote.StoneValue);
        Assert.Equal(53280m, quote.Subtotal);
    }

    [Fact]
    public void Calculate_LowMakingCharge_UsesMinimumPerPiece()
    {
        // 0.4 g x 950 = 380, below the 500 minimum
        var quote = _pricing.Calculate(new QuoteRequest(0.4m, 6200m, 950m, null));

        Assert.Equal(500m, quote.MakingCharge);
    }

    [Fact]
    public void Calculate_ZeroWeight_Throws()
    {
        Assert.Throws<ArgumentOutOfRangeException>(() => _pricing.Calculate(new QuoteRequest(0m, 6200m, 950m, null)));
    }
}
