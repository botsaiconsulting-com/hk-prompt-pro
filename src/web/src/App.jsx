import { useState } from 'react';
import MonthlySales from './components/MonthlySales.jsx';

const COMPANIES = [
  { code: 'surat', label: 'Surat' },
  { code: 'india-a', label: 'India A' },
  { code: 'india-b', label: 'India B' },
];

export default function App() {
  const [company, setCompany] = useState('surat');

  return (
    <main style={{ fontFamily: 'system-ui, sans-serif', padding: 24, maxWidth: 960 }}>
      <h1>HK Supreme (training)</h1>
      <p>
        Dummy data only. The legacy order entry screen is at <a href="/legacy/order-entry.html">/legacy/order-entry.html</a>.
      </p>
      <label>
        Company{' '}
        <select value={company} onChange={(e) => setCompany(e.target.value)}>
          {COMPANIES.map((c) => (
            <option key={c.code} value={c.code}>
              {c.label}
            </option>
          ))}
        </select>
      </label>
      <MonthlySales company={company} from="2026-07-01" to="2026-10-01" />
    </main>
  );
}
