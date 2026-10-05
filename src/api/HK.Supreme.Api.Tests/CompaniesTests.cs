using HK.Supreme.Api.Data;

namespace HK.Supreme.Api.Tests;

public class CompaniesTests
{
    [Theory]
    [InlineData("surat", "HK_SURAT")]
    [InlineData("india-a", "HK_INDIA_A")]
    [InlineData("INDIA-B", "HK_INDIA_B")]
    public void CatalogFor_KnownCompany_ReturnsDatabase(string company, string expected)
    {
        Assert.Equal(expected, Companies.CatalogFor(company));
    }

    [Fact]
    public void CatalogFor_UnknownCompany_Throws()
    {
        Assert.Throws<ArgumentException>(() => Companies.CatalogFor("mumbai"));
    }
}
