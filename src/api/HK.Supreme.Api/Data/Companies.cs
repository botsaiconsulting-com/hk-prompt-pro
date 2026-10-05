namespace HK.Supreme.Api.Data;

/// <summary>
/// The three company databases created by the move from SAP to Gati. One database per company.
/// </summary>
public static class Companies
{
    private static readonly IReadOnlyDictionary<string, string> Catalogs =
        new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
            ["surat"] = "HK_SURAT",
            ["india-a"] = "HK_INDIA_A",
            ["india-b"] = "HK_INDIA_B",
        };

    public static IEnumerable<string> Codes => Catalogs.Keys;

    public static bool IsKnown(string company) => Catalogs.ContainsKey(company);

    public static string CatalogFor(string company) =>
        Catalogs.TryGetValue(company, out var catalog)
            ? catalog
            : throw new ArgumentException($"Unknown company '{company}'.", nameof(company));
}
