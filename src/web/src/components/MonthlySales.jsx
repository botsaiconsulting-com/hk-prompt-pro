import { useEffect, useState } from 'react';
import { getMonthlySales } from '../lib/api.js';
import { formatInr } from '../lib/format.js';

export default function MonthlySales({ company, from, to, fetchImpl }) {
  const [rows, setRows] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError(null);
    getMonthlySales(company, from, to, fetchImpl)
      .then((data) => {
        if (!cancelled) setRows(data);
      })
      .catch((e) => {
        if (!cancelled) setError(e.message);
      })
      .finally(() => {
        if (!cancelled) setLoading(false);
      });
    return () => {
      cancelled = true;
    };
  }, [company, from, to, fetchImpl]);

  if (loading) return <p>Loading monthly sales...</p>;
  if (error) return <p role="alert">Could not load monthly sales: {error}</p>;
  if (rows.length === 0) return <p>No sales in this period.</p>;

  return (
    <table>
      <thead>
        <tr>
          <th>Month</th>
          <th>Customer</th>
          <th>Net value</th>
        </tr>
      </thead>
      <tbody>
        {rows.map((r) => (
          <tr key={`${r.salesMonth}-${r.customerCode}`}>
            <td>{r.salesMonth}</td>
            <td>
              {r.customerName} ({r.customerCode})
            </td>
            <td>{formatInr(r.netValue)}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}
