using System.Data.Common;

namespace HK.Supreme.Api.Data;

public interface ICompanyConnectionFactory
{
    /// <summary>Opens a connection to one company's database.</summary>
    Task<DbConnection> OpenAsync(string company, CancellationToken cancellationToken);
}
