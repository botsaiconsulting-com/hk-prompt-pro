import { render, screen } from '@testing-library/react';
import { describe, expect, it, vi } from 'vitest';
import MonthlySales from './MonthlySales.jsx';

function fakeFetch(body, ok = true, status = 200) {
  return vi.fn().mockResolvedValue({ ok, status, json: () => Promise.resolve(body) });
}

describe('MonthlySales', () => {
  it('shows one row per month and customer', async () => {
    const fetchImpl = fakeFetch([
      { company: 'surat', customerCode: 'AUR001', customerName: 'Aurora Retail Group', salesMonth: '2026-07', netValue: 1368000 },
    ]);

    render(<MonthlySales company="surat" from="2026-07-01" to="2026-10-01" fetchImpl={fetchImpl} />);

    expect(await screen.findByText('Aurora Retail Group (AUR001)')).toBeInTheDocument();
    expect(screen.getByText('₹13,68,000')).toBeInTheDocument();
    expect(fetchImpl).toHaveBeenCalledWith('/api/orders/surat/monthly-sales?from=2026-07-01&to=2026-10-01');
  });

  it('shows an error when the API fails', async () => {
    const fetchImpl = fakeFetch(null, false, 500);

    render(<MonthlySales company="india-b" from="2026-07-01" to="2026-10-01" fetchImpl={fetchImpl} />);

    expect(await screen.findByRole('alert')).toHaveTextContent('Monthly sales request failed (500)');
  });
});
